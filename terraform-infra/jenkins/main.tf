
module "security_groups" {
  source                      = "../modules/security-groups"
  vpc_id                      = module.vpc.vpc_id
  allowed_ssh_cidr_blocks     = ["0.0.0.0/0"]
  allowed_jenkins_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key-${random_id.suffix.hex}" 
  public_key = file(var.public_key_path)
}

module "ec2" {
  source            = "../modules/ec2"
  ami_id            = "ami-00be607689b5407d1"
  instance_type     = "t3.micro"
  key_name          = aws_key_pair.jenkins_key.key_name
  security_group_id = module.security_groups.security_group_id
  public_subnet_id  = module.vpc.subnet_id
  instance_name     = "jenkins-server"
  user_data_path    = "${path.root}/user_data.sh"
  additinal_tags = {  
    Environment = "dev"
    Project    = "jenkinsinfra"
  }
}

module "vpc" {
  source             = "../modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  public_subnet_az   = "ap-south-1a"
  vpc_name           = "jenkins_vpc"
}
resource "random_id" "suffix" {
  byte_length = 4
}

module "state_backend" {
  source              = "../modules/state-backend"
  bucket_name         = "jenkins-terraform-state-bucket-${random_id.suffix.hex}"
  dynamodb_table_name = "jenkins-terraform-lock-table-${random_id.suffix.hex}"
  environment         = "dev"
}