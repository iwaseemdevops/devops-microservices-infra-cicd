#!/bin/bash

# --- Update ---
sudo yum update -y

# --- Install Docker ---
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# --- Add Jenkins Repo ---
sudo tee /etc/yum.repos.d/jenkins.repo > /dev/null <<EOF
[jenkins]
name=Jenkins-stable
baseurl=https://pkg.jenkins.io/redhat-stable
gpgcheck=1
gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io.key https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
enabled=1
EOF

# --- Import BOTH old & new GPG keys ---
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# --- Install Java 17 required for Jenkins ---
sudo amazon-linux-extras enable corretto17
sudo yum install -y java-17-amazon-corretto-devel

# --- Install Jenkins ---
sudo yum clean all
sudo yum install -y jenkins

# --- Add Jenkins to Docker group ---
sudo usermod -aG docker jenkins

# --- Start Jenkins ---
sudo systemctl start jenkins
sudo systemctl enable jenkins
