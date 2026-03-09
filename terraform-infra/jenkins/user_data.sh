#!/bin/bash

# Update system
sudo yum update -y

# Install Java (Required for Jenkins)
sudo yum install -y java-17-amazon-corretto

# Install Docker
sudo amazon-linux-extras install docker -y

sudo systemctl start docker
sudo systemctl enable docker

# Allow ec2-user to run Docker
sudo usermod -aG docker ec2-user

# Add Jenkins Repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins Key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo yum install -y jenkins

# Add Jenkins to Docker group
sudo usermod -aG docker jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Restart Docker & Jenkins
sudo systemctl restart docker
sudo systemctl restart jenkins

# Create 2GB Swap (important for t2/t3 instances)
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make swap permanent
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

# Display Jenkins initial password
echo "Jenkins Initial Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Install Terraform
sudo apt update
sudo apt install unzip -y

wget https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip
unzip terraform_1.9.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version

# install netcat for health checks
sudo yum install -y nc