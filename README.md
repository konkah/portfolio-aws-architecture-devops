# Portfolio AWS Architecture DevOps

Welcome to the **Portfolio AWS Architecture DevOps** repository!
This project demonstrates a robust, cloud-native infrastructure for deploying a FastAPI application on AWS using Infrastructure as Code (IaC) principles with Terraform.
It emphasizes scalability, automation, modularity, and best practices for containerized workloads.

---

## 🗂️ Table of Contents

- [Portfolio AWS Architecture DevOps](#portfolio-aws-architecture-devops)
  - [🗂️ Table of Contents](#️-table-of-contents)
  - [📖 About the Project](#-about-the-project)
  - [🏗️ Architecture Overview](#️-architecture-overview)
  - [✨ Features](#-features)
  - [🛠️ Tech Stack](#️-tech-stack)
  - [📁 Project Structure](#-project-structure)
  - [🚦 Getting Started](#-getting-started)
    - [1. **Clone the Repository**](#1-clone-the-repository)
    - [2. **Configure Your Environment**](#2-configure-your-environment)
    - [3. **Build \& Push Docker Image**](#3-build--push-docker-image)
    - [4. **Provision AWS Infrastructure**](#4-provision-aws-infrastructure)
      - [**Option 1: Using Makefile Commands**](#option-1-using-makefile-commands)
      - [**Option 2: Using Terraform Directly**](#option-2-using-terraform-directly)
    - [5. **Access Your Application**](#5-access-your-application)
  - [⚡ Usage \& Automation](#-usage--automation)
    - [Common Makefile Commands](#common-makefile-commands)
  - [📤 Outputs](#-outputs)
  - [🛠️ Customization](#️-customization)
  - [🛡️ AWS IAM Policies](#️-aws-iam-policies)
  - [📝 License \& Author](#-license--author)

---

## 📖 About the Project

This repository provides a complete solution for deploying a **FastAPI** application using AWS managed services.
Everything is automated: from provisioning the cloud infrastructure to building Docker images and running them in ECS Fargate behind a load balancer with centralized log management.

---

## 🏗️ Architecture Overview

Below is a high-level overview of the infrastructure workflow:

1. 👨‍💻 **Developer** pushes code to **GitHub**.
2. ⚙️ **Terraform** provisions AWS resources:
   - 🐳 **ECR**: Docker image storage
   - 🚀 **ECS Fargate**: Runs containers
   - 🌐 **VPC/Subnets/Security Groups**: Networking & security
   - ☁️ **ALB**: Load balancing to containers
   - 📊 **CloudWatch**: Centralized logs
3. 🏗️ Docker images are built & pushed to ECR.
4. 🚀 ECS Fargate pulls the images and runs the app.
5. 🌐 ALB routes user requests to the containers.
6. 📊 Logs are collected in CloudWatch.

---

## ✨ Features

- **Modular Terraform**: Clean and reusable modules for networking, compute, logging, and containers.
- **ECS Fargate Deployment**: Serverless containers for simplified ops and scalability.
- **Elastic Container Registry (ECR)**: Secure storage and lifecycle management for Docker images.
- **Load Balanced**: Traffic managed by AWS Application Load Balancer (ALB).
- **Centralized Logging**: All container logs shipped to AWS CloudWatch.
- **Secure Networking**: Custom VPC, public subnets, managed security groups.
- **Automation via Makefile**: One-liners for common workflows: plan, apply, destroy, validate, and more.
- **Production-Ready Dockerfile**: Optimized FastAPI build, dependency management pinned with pip-tools.

---

## 🛠️ Tech Stack

- **Language:** Python (FastAPI)
- **Containerization:** Docker
- **IaC:** Terraform
- **Cloud:** Amazon Web Services (ECS, ECR, VPC, ALB, CloudWatch)
- **Automation:** Makefile

---

## 📁 Project Structure

```
portfolio-aws-architecture-devops/
│
├── application/
│   └── containers/
│       └── fastapi.Dockerfile
│
├── terraform/
│   └── aws/
│       ├── main.tf
│       ├── outputs.tf
│       └── modules/
│           ├── containers/
│           ├── image-registry/
│           ├── logs/
│           ├── network/
│           └── load-balancer/
│
├── env/
│   ├── example.env
│   └── example.tfvars
│
├── docs/
│   └── aws-policies/         # Example IAM policies required for the project
│
├── Makefile
└── README.md
```

---

## 🚦 Getting Started

### 1. **Clone the Repository**

```bash
git clone https://github.com/konkah/portfolio-aws-architecture-devops.git
cd portfolio-aws-architecture-devops
```

### 2. **Configure Your Environment**

- Copy the example environment files and edit them with your own values:

```bash
cp env/example.env env/dev.env
cp env/example.tfvars env/prod.tfvars
```

- Open the copied files (`env/dev.env` and `env/prod.tfvars`) in your text editor and update the variable values with your AWS credentials and configuration.

> **Note:**
> Do **not** edit the `example.*` files directly. Always copy them to create your own local configuration files and update those copies.

### 3. **Build & Push Docker Image**

Terraform automates image build/push, but for local development:

```bash
make app-start
```

### 4. **Provision AWS Infrastructure**

You can provision the AWS infrastructure using either **Makefile commands** (recommended for simplicity) or direct Terraform commands.

#### **Option 1: Using Makefile Commands**

```bash
make cloud-init-aws         # Initialize Terraform for AWS
make cloud-plan-aws         # Show the Terraform execution plan
make cloud-start-aws        # Apply and provision all AWS resources
```

#### **Option 2: Using Terraform Directly**

```bash
cd terraform/aws
terraform init
terraform plan -var-file="../../env/prod.tfvars"
terraform apply -var-file="../../env/prod.tfvars" -auto-approve
```

> **Tip:**
> The Makefile wraps the corresponding Terraform commands for your convenience. Use either method according to your preference!

### 5. **Access Your Application**

- Find the output `lb_dns_name` and open in your browser:
  ```
  http://<load-balancer-dns>
  ```

---

## ⚡ Usage & Automation

### Common Makefile Commands

| Command                 | Description                                 |
|-------------------------|---------------------------------------------|
| `make app-start`        | Start local app containers with Docker      |
| `make app-finish`       | Stop and remove containers                  |
| `make cloud-init-aws`   | Terraform init for AWS                      |
| `make cloud-plan-aws`   | Terraform plan for AWS                      |
| `make cloud-start-aws`  | Apply (deploy) AWS infrastructure           |
| `make cloud-finish-aws` | Destroy all AWS resources                   |
| `make cloud-validate-aws` | Validate Terraform config                 |

---

## 📤 Outputs

After a successful deployment, Terraform provides:

- **ECR Info:**
  - URL and repository name for Docker images

- **ECS Info:**
  - Cluster and service names, task definition ARN

- **Networking:**
  - VPC ID, public subnet IDs, ALB DNS name

- **Logging:**
  - CloudWatch Log Group name/ARN

Example output:
```
ecr_repository_url = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/portfolio-api-container-hub"
lb_dns_name = "portfolio-alb-123456789.eu-west-1.elb.amazonaws.com"
cloudwatch_log_group_name = "portfolio-api-logs"
```

---

## 🛠️ Customization

- **Application Code:**
  Edit `application/containers/fastapi.Dockerfile` and source files for your FastAPI logic.

- **Infrastructure Variables:**
  Change any Terraform variables in the `env/prod.tfvars` or module variable files.

- **Scaling:**
  Adjust `desired_count` in ECS, subnet CIDRs, or other capacity settings as needed.

---

## 🛡️ AWS IAM Policies

The project requires specific AWS IAM permissions for Terraform to provision and manage resources.
**Example policy documents** can be found in the [`docs/aws-policies/`](docs/aws-policies/) directory.

> **Important:**
> Ensure your AWS user or role has permissions as defined in these policy files before running Terraform.
> Assign only the permissions needed for security best practices.

---

## 📝 License & Author

**License:** MIT
**Author:** [Karlos Helton Braga (Konkah)](https://github.com/konkah)

---

> _Feel free to fork, adapt, or reach out for improvements or questions!_
