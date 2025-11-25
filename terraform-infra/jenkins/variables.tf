variable "instance_type" {
  description = "EC2 instance type for the Jenkins server"
  type        = string
  default     = "t3.micro"
}
variable "ami_id" {
  description = "Amazon Linux 2 AMI for ap-south-1"
  type        = string
  default     = "ami-00be607689b5407d1"
}

variable "vpc_id" {
  description = "VPC ID where Jenkins server will be deployed"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID for Jenkins server"
  type        = string
  default     = ""
}
variable "public_key_path" {
  description = "Path to the public key for SSH access"
  type        = string
  default     = "/home/obito/.ssh/id_ed25519.pub"
}