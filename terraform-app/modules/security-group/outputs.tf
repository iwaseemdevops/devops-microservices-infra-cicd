output "jenkins_sg_id" {
  description = "Jenkins security group ID"
  value       = aws_security_group.jenkins_sg.id
}

output "app_sg_id" {
  description = "App security group ID"
  value       = aws_security_group.app_sg.id
}