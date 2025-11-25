output "vpc_id" {
    value = aws_vpc.jenkins_vpc.id
}
output "public_subnet_id" {
    value = aws_subnet.jenkins_public_subnet.id
}
output "subnet_id" {
    value = aws_subnet.jenkins_public_subnet.id
}