#!/bin/bash
set -e  # Stop on any error

# Swap file setup ───────────────────────────────────────────────
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

# Update system ──────────────────────────────────────────────
sudo yum update -y

# Install Java ───────────────────────────────────────────────
sudo yum install -y java-17-amazon-corretto

# Install Docker ─────────────────────────────────────────────
# For Amazon Linux 2:
sudo amazon-linux-extras install docker -y

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Install Jenkins ────────────────────────────────────────────
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum install -y jenkins
sudo usermod -aG docker jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install utilities  ─────────────────────
sudo yum install -y unzip nc

# Install git
sudo yum install -y git

# Install Terraform ──────────────────────────────────────────
wget https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip
unzip terraform_1.9.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.9.7_linux_amd64.zip  # cleanup
terraform version

# Restart services with a pause ─────────────────────────────
sudo systemctl restart docker
sleep 5
sudo systemctl restart jenkins
sleep 10

# Show Jenkins password ──────────────────────────────────────
echo "==============================="
echo " Jenkins Initial Password:"
echo "==============================="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword