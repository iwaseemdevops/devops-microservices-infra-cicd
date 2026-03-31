# DevOps Microservices Infrastructure & CI/CD Pipeline

A production-grade DevOps project demonstrating end-to-end
automation — from infrastructure provisioning to microservices
deployment — using Terraform, Jenkins, Docker, and AWS.

## Architecture Overview

```
GitHub Push → Jenkins Pipeline → Terraform provisions AWS EC2
                                        ↓
                              Docker + docker-compose deployed
                                        ↓
                         Nginx reverse proxy → Live application

Jenkins Infrastructure (24/7):     App Infrastructure (on-demand):
terraform-infra/                   terraform-app/
  └── Jenkins EC2 (always on)        └── App EC2 (deploy & destroy)
```

## What This Project Does

This project provisions and deploys a microservices e-commerce
application on AWS using a fully automated Jenkins CI/CD pipeline.
Two separate Terraform infrastructures are managed independently:

1. Jenkins Infrastructure — always running EC2 instance hosting
   Jenkins server with all required plugins and credentials
2. App Infrastructure — provisioned on demand via pipeline,
   destroyed after use to eliminate AWS costs

## Microservices

| Service         | Description             | Port |
| --------------- | ----------------------- | ---- |
| Frontend        | React-based UI          | 3000 |
| Product Service | Product catalog API     | 8080 |
| Offer Service   | Discount and offers API | 8090 |
| Database        | Persistent data store   | 5432 |

## Tech Stack

- **CI/CD:** Jenkins (declarative pipeline, parameterized builds)
- **IaC:** Terraform (modular — separate Jenkins + App infra)
- **Containers:** Docker, docker-compose
- **Cloud:** AWS EC2, VPC, Security Groups, IAM
- **Proxy:** Nginx reverse proxy
- **Registry:** Docker Hub

## Pipeline Stages

```
Checkout → Terraform Init → Terraform Plan → Terraform Apply
→ Fix SSH Permissions → Fetch EC2 IP → Wait for SSH
→ Copy docker-compose → Install Docker on EC2
→ Deploy Containers → Application Live
```

Destroy mode: single parameter flip tears down all infrastructure.

## Key Engineering Decisions

**Two separate Terraform modules** — Jenkins infrastructure is
permanent (always-on EC2), app infrastructure is ephemeral
(created per deployment, destroyed to save cost). This reflects
real-world cost optimization practices.

**Dynamic EC2 IP** — pipeline fetches the app server IP directly
from Terraform output after provisioning. No hardcoded IPs anywhere.

**SSH readiness check** — pipeline waits with a timeout loop until
EC2 SSH is available before attempting deployment. Prevents
race conditions on fresh instance startup.

**Secure credentials** — AWS credentials injected via Jenkins
credential store using `withCredentials`. No secrets in code.

## How to Run

### Prerequisites

- Jenkins server running (use terraform-infra/ to provision)
- AWS credentials configured in Jenkins as `aws-creds`
- Docker Hub account

### Deploy

1. Create pipeline job in Jenkins
2. Point to this repository
3. Run with `DESTROY=false` and your EC2 key pair name
4. Application available at `http://<EC2_IP>:3000`

### Destroy

1. Run pipeline with `DESTROY=true`
2. All AWS resources removed automatically

## Screenshots

[Add your screenshots here — Jenkins pipeline green stages,
Terraform apply output, running application in browser,
docker-compose ps showing all containers healthy]

## Repository Structure

```
devops-microservices-infra-cicd/
├── microservices-shop/          # Application code + docker-compose
│   ├── frontend/
│   ├── product-service/
│   ├── offer-service/
│   └── docker-compose.yaml
├── terraform-app/               # App infrastructure (Terraform)
│   └── envs/dev/
├── terraform-infra/             # Jenkins infrastructure (Terraform)
└── Jenkinsfile                  # Full CI/CD pipeline definition
```

## What I Learned

- Managing multiple Terraform environments independently
- Parameterized Jenkins pipelines with destroy capability
- SSH automation and EC2 bootstrap via pipeline
- Microservices containerization and orchestration
- Real-world cost optimization on AWS Free Tier

## Author

**Waseem Aqib** — DevOps Engineer  
[GitHub](https://github.com/iwaseemdevops) |
[LinkedIn](https://linkedin.com/in/waseemaqib) |
iwaseemdevops@gmail.com
