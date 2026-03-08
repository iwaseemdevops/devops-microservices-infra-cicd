# 🛍️ Microservice Shop

A **microservices-based shop application** built with **Docker, Docker Compose, Kubernetes, Jenkins, and Ansible**.  
This project demonstrates containerized microservices, orchestration, CI/CD automation, and configuration management for a real-world DevOps workflow.

---

## 🚀 Features

- **Frontend (Node.js + Express)** – Simple shop UI to display products & offers.
- **Product Service** – Provides product catalog (e.g., Laptop, Phone).
- **Offer Service** – Provides discount offers (e.g., WELCOME10, FEST20).
- **MongoDB** – Database backend for microservices.
- **Docker Compose** – Local development and testing with multi-container setup.
- **Kubernetes (coming soon)** – Deployment on Minikube/K8s cluster.
- **Jenkins Pipeline** – CI/CD automation for build & deploy.
- **Ansible (coming soon)** – Automated provisioning and configuration management.

---

## 🏗️ Tech Stack

- **Backend:** Node.js, Express
- **Frontend:** Node.js + HTML/CSS
- **Database:** MongoDB
- **Containerization:** Docker, Docker Compose
- **Orchestration:** Kubernetes (Minikube)
- **CI/CD:** Jenkins
- **Configuration Management:** Ansible

---

## 📂 Project Structure

microservice-shop/
│── frontend-service/ # UI for the shop
│ ├── app.js # Frontend logic
│ ├── index.html # UI template
│ └── Dockerfile
│
│── product-service/ # Provides product data
│ ├── app.js
│ └── Dockerfile
│
│── offer-service/ # Provides discount offers
│ ├── app.js
│ └── Dockerfile
│
│── docker-compose.yaml # Local multi-service setup

## ⚡ Getting Started

### Clone the repo

git clone git@github.com:iwaseemdevops/microservice-shop.git
cd microservice-shop

### ⚡ Build and push Docker images

# Build images

docker build -t iwaseemdevops/product-service:latest ./product-service
docker build -t iwaseemdevops/offer-service:latest ./offer-service
docker build -t iwaseemdevops/frontend-service:latest ./frontend-service

# Push images to Docker Hub

docker push iwaseemdevops/product-service:latest
docker push iwaseemdevops/offer-service:latest
docker push iwaseemdevops/frontend-service:latest

### Run with Docker Compose

# Pull images from Docker Hub

docker-compose pull

# Start all services

docker-compose up -d

# Access the app

Frontend: http://localhost:3000

Product Service: http://localhost:8081/products

Offer Service: http://localhost:8082/offers

### 👨‍💻 Author

Waseem Aqib
📧 Email: iwaseemdevops@gmail.com

🔗 LinkedIn: linkedin.com/in/waseemaqib

🐙 GitHub: github.com/iwaseemdevops
