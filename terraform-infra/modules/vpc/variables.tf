variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "public_subnet_az" {
  description = "The availability zone for the public subnet"
  type        = string
  default     = "ap-south-1a"
}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "jenkins_vpc"
}
