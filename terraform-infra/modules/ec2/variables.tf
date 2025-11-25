variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
 
}
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}
variable "public_subnet_id" {
  description = "The subnet ID where the EC2 instance will be launched"
  type        = string
}
variable "security_group_id" {
  description = "The security group ID to associate with the EC2 instance"
  type        = string
} 
variable "key_name" {
  description = "The key pair name to access the EC2 instance"
  type        = string

} 
variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
  default     = "jenkins-instance"
}
variable "additinal_tags" {
  description = "Additional tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}
variable "user_data_path" {
  description = "Path to user_data script"
  type        = string
  default     = null
}
