# Portfolio AWS Architecture DevOps

Welcome to the **Portfolio AWS Architecture DevOps** repository!
This project demonstrates a robust, cloud-native infrastructure for deploying FastAPI applications on AWS using Infrastructure as Code (IaC) with Terraform.
The focus is on scalability, automation, modularity, and best practices for both containerized and VM-based workloads.

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
Everything is automated: from provisioning cloud infrastructure to building Docker images and running them in both ECS Fargate and EC2 VMs, all behind a load balancer with centralized log management.

---

## 🏗️ Architecture Overview

High-level infrastructure workflow:

1. 👨‍💻 **Developer** pushes code to **GitHub**.
2. ⚙️ **Terraform** provisions AWS resources:
   - 🐳 **ECR**: Docker image storage
   - 🚀 **ECS Fargate & EC2**: Containers and VMs for deployment
   - 🌐 **VPC/Subnets/Security Groups**: Networking & security
   - ☁️ **ALB**: Load balancing for containers and VMs
   - 📊 **CloudWatch**: Centralized logging
3. 🏗️ Docker images are built and pushed to ECR.
4. 🚀 ECS Fargate and/or EC2 pull the images and run the app.
5. 🌐 ALB routes requests to containers or VMs.
6. 📊 Logs are collected in CloudWatch.

---

## ✨ Features

- **Modular Terraform**: Clean and reusable modules for networking, VMs, containers, logging, and image registry.
- **Deploys to Containers (ECS) and VMs (EC2)**: Flexibility for different workloads.
- **Elastic Container Registry (ECR)**: Secure Docker image storage.
- **Application Load Balancer (ALB)**: Managed traffic for containers and VMs.
- **Centralized Logging**: All logs shipped to CloudWatch.
- **Secure Networking**: Custom VPC, public subnets, dedicated security groups.
- **Automation via Makefile**: Streamlined workflows (plan, apply, destroy, validate, etc).
- **Production-Ready Dockerfile**: Optimized build, dependency management via pip-tools.
- **CI/CD with GitHub Actions**: Automated testing and continuous deployment.

---

## 🛠️ Tech Stack

- **Language:** Python (FastAPI)
- **Containerization:** Docker
- **Infrastructure as Code:** Terraform
- **Cloud:** AWS (ECS, EC2, ECR, VPC, ALB, CloudWatch)
- **Automation:** Makefile, GitHub Actions

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
│           ├── image-registries/
│           ├── logs/
│           ├── load-balancers/
│           ├── networks/
│           └── vms/
│
├── env/
│   ├── example.env
│   └── example.tfvars
│
├── docs/
│   └── aws-policies/         # Example IAM policies for the project
│
├── .github/
│   └── workflows/            # GitHub Actions CI/CD workflows
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

- Edit `env/dev.env` and `env/prod.tfvars` with your AWS credentials and configuration.

> **Note:**
> Do **not** edit the `example.*` files directly. Always create local copies and update those copies.

### 3. **Build & Push Docker Image**

Terraform automates image build/push, but for local development:

```bash
make app-start
```

### 4. **Provision AWS Infrastructure**

You can provision the AWS infrastructure using **Makefile commands** (recommended) or direct Terraform commands.

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
> The Makefile wraps the corresponding Terraform commands for your convenience.

### 5. **Access Your Application**

- Find the output `lb_dns_name` and open it in your browser:
  ```
  http://<load-balancer-dns>
  ```

---

## ⚡ Usage & Automation

### Common Makefile Commands

| Command                     | Description                                    |
|-----------------------------|------------------------------------------------|
| `make app-start`            | Start local app containers with Docker         |
| `make app-finish`           | Stop and remove local containers               |
| `make cloud-init-aws`       | Initialize Terraform for AWS                   |
| `make cloud-plan-aws`       | Show Terraform plan for AWS                    |
| `make cloud-start-aws`      | Apply (deploy) AWS infrastructure              |
| `make cloud-finish-aws`     | Destroy all AWS infrastructure                 |
| `make cloud-validate-aws`   | Validate Terraform configuration               |

---

## 📤 Outputs

After a successful deployment, Terraform provides:

- **ECR**: URL and repository name for Docker images
- **ECS/EC2**: Cluster/service names, task definition ARNs, instance IDs
- **Networking**: VPC ID, subnets, ALB DNS name
- **Logging**: CloudWatch Log Group name/ARN

Example output:
```
ecr_repository_url = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/portfolio-api-container-hub"
lb_dns_name = "portfolio-alb-123456789.eu-west-1.elb.amazonaws.com"
cloudwatch_log_group_name = "portfolio-api-logs"
```

---

## 🛠️ Customization

- **Application Code:**
  Edit `application/containers/fastapi.Dockerfile` and relevant source files for your FastAPI logic.

- **Infrastructure Variables:**
  Change values in `env/prod.tfvars` or module variables files.

- **Scaling:**
  Adjust `desired_count` in ECS/EC2 modules, subnet CIDRs, instance types, etc.

---

## 🛡️ AWS IAM Policies

The project requires specific AWS IAM permissions for Terraform to provision and manage resources.
**Example policy documents** can be found in the [`docs/aws-policies/`](docs/aws-policies/) directory.

> **Important:**
> Make sure your AWS user or role has permissions as defined in these policy files before running Terraform.

---

## 📝 License & Author

**License:** MIT
**Author:** [Karlos Helton Braga (Konkah)](https://github.com/konkah)

---

> _Feel free to fork, adapt, or reach out for improvements or questions!_
