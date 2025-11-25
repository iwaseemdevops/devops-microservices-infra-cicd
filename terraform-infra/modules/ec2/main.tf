resource "aws_instance" "jenkins_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
    user_data = file(
    var.user_data_path != null ? var.user_data_path : "${path.module}/user_data.sh"
  )
  associate_public_ip_address = true
  tags = merge(
    {
      Name = var.instance_name
    },
    var.additinal_tags
  )
}