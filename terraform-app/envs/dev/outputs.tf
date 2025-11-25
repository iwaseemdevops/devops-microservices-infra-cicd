

output "app_server_public_ip" {
  description = "Public IP of app server"
  value       = module.app_server.public_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}