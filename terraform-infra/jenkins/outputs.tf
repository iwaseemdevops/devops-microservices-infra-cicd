output "jenkins_public_ip" {
  value = module.ec2.instance_public_ip
}

output "jenkins_public_dns" {
  value = module.ec2.instance_public_dns
}

output "jenkins_url" {
  value = "http://${module.ec2.instance_public_ip}:8080"
}
output "state_bucket_name" {
  value = module.state_backend.s3_bucket_name
}

output "lock_table_name" {
  value = module.state_backend.dynamodb_table_name
}