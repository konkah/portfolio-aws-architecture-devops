terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
    bucket = "konkah-portfolio-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region = var.AWS_REGION
}

// Used by get the current aws number account.
data "aws_caller_identity" "current" {
}

module "image-registry" {
  source     = "./modules/image-registry"

  ECR_AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  ECR_AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  ECR_AWS_REGION            = var.AWS_REGION
  ECR_AWS_ZONE_1            = var.AWS_ZONE_1
  ECR_AWS_ZONE_2            = var.AWS_ZONE_2
  ECR_UNTAGGED_IMAGES       = var.UNTAGGED_IMAGES
}

module "network" {
  source     = "./modules/network"

  VPC_IP            = var.VPC_IP
  VPC_AWS_ZONE_1    = var.AWS_ZONE_1
  VPC_AWS_ZONE_2    = var.AWS_ZONE_2
  VPC_SUBNET1_IP    = var.VPC_SUBNET1_IP
  VPC_SUBNET2_IP    = var.VPC_SUBNET2_IP
}

module "load-balancer" {
  source     = "./modules/load-balancer"

  LB_VPC_ID                = module.network.vpc_id
  LB_SUBNET_ID_LIST        = module.network.vpc_public_subnet_id_list
}

module "containers" {
  source     = "./modules/containers"

  ECS_AWS_REGION              = var.AWS_REGION
  ECS_VPC_ID                  = module.network.vpc_id
  ECS_CONTAINERS_IMAGE_URL    = module.image-registry.ecr_repository_url_version
  ECS_LB_TARGET_GROUP_ARN     = module.load-balancer.lb_target_group_arn
  ECS_SUBNET_ID_LIST          = module.network.vpc_public_subnet_id_list
  ECS_LB_SECURITY_GROUP_LIST  = [module.load-balancer.lb_security_group_id]
  ECS_LOG_GROUP_NAME          = module.logs.cloudwatch_log_group_name
}

module "logs" {
  source     = "./modules/logs"

  LOGS_AWS_REGION = var.AWS_REGION
}
