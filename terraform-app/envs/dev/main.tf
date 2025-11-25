# Create key pair if it doesn't exist
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "app-key"
  public_key = tls_private_key.this.public_key_openssh
}

# Save private key to file (be careful with this!)
resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${path.module}/app-key.pem"
  file_permission = "0400"
}
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.20.0/24"]
  azs             = ["ap-south-1a", "ap-south-1b"]
  environment     = "dev"
}

module "sg" {
  source = "../../modules/security-group"

  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr_block
  environment = "dev"
}

# App Server (for microservices)
module "app_server" {
  source = "../../modules/ec2"

  ami_id        = "ami-00be607689b5407d1" # Amazon Linux 2023
  instance_type = "t3.small"
  key_name      = aws_key_pair.this.key_name 
  subnet_id     = module.vpc.public_subnets[1]
  sg_id         = [module.sg.app_sg_id]
  
  # Add user_data to install web server
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl enable httpd
              sudo systemctl start httpd
              echo "<h1>Hello from Microservices App Server</h1>" | sudo tee /var/www/html/index.html
              EOF

  instance_name = "app-server"
  environment   = "dev"
  volume_size   = 20
}