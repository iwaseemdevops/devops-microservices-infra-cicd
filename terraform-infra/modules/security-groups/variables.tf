variable "vpc_id" {
    description = "The VPC ID where the security group will be created"
    type        = string
    
}
variable "key_name" {
    description = "The name of the key pair"
    type        = string
    default     = "jenkins-keypair"
}
variable "public_key_path" {
    description = "The file path to the public key for the key pair"
    type        = string
    default     = "/home/obito/.ssh/id_ed25519.pub"
}
variable "allowed_ssh_cidr_blocks" {
    description = "List of CIDR blocks allowed to access via SSH"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}
variable "allowed_jenkins_cidr_blocks" {
    description = "List of CIDR blocks allowed to access Jenkins web interface"
    type        = list(string)
    default     = ["0.0.0.0/0"]
}   
