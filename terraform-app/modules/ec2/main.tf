resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_id
  key_name               = var.key_name
  user_data              = var.user_data

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
    encrypted   = true
  }

  tags = merge(
    {
      Name        = var.instance_name
      Environment = var.environment
      Project     = "jenkins-microservices"
    },
    var.tags
  )
}

