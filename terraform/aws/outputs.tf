# Image Registries
output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = module.image-registries.ecr_repository_name
}

output "ecr_repository_url" {
  description = "The full ECR repository URL (without tag)"
  value       = module.image-registries.ecr_repository_url
}

output "ecr_repository_url_version" {
  description = "The full ECR repository URL (with tag)"
  value       = module.image-registries.ecr_repository_url_version
}

output "ecr_account_id" {
  description = "AWS Account ID used for ECR"
  value       = module.image-registries.ecr_account_id
}


# Networks
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.networks.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = module.networks.vpc_cidr_block
}

output "vpc_public_subnet_id_list" {
  description = "List of public subnet IDs"
  value       = module.networks.vpc_public_subnet_id_list
}

output "vpc_availability_zone_list" {
  description = "List of availability zones used for subnets"
  value       = module.networks.vpc_availability_zone_list
}

output "vpc_internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.networks.vpc_internet_gateway_id
}

output "vpc_route_table_id" {
  description = "ID of the public route table"
  value       = module.networks.vpc_route_table_id
}


# Load Balancers
# EC2
output "lb_ec2_arn" {
  description = "The ARN of the ec2 Application Load Balancer"
  value       = module.load-balancers.lb_ec2_arn
}

output "lb_ec2_dns_name" {
  description = "The DNS name of the ec2 Application Load Balancer"
  value       = module.load-balancers.lb_ec2_dns_name
}

output "lb_ec2_security_group_id" {
  description = "The security group ID associated with the ec2 Load Balancer"
  value       = module.load-balancers.lb_ec2_security_group_id
}

output "lb_ec2_target_group_arn" {
  description = "The ARN of the ec2 Load Balancer Target Group"
  value       = module.load-balancers.lb_ec2_target_group_arn
}

output "lb_ec2_listener_arn" {
  description = "The ARN of the ec2 Load Balancer Listener"
  value       = module.load-balancers.lb_ec2_listener_arn
}

# ECS
output "lb_ecs_arn" {
  description = "The ARN of the ECS Application Load Balancer"
  value       = module.load-balancers.lb_ecs_arn
}

output "lb_ecs_dns_name" {
  description = "The DNS name of the ECS Application Load Balancer"
  value       = module.load-balancers.lb_ecs_dns_name
}

output "lb_ecs_security_group_id" {
  description = "The security group ID associated with the ECS Load Balancer"
  value       = module.load-balancers.lb_ecs_security_group_id
}

output "lb_ecs_target_group_arn" {
  description = "The ARN of the ECS Load Balancer Target Group"
  value       = module.load-balancers.lb_ecs_target_group_arn
}

output "lb_ecs_listener_arn" {
  description = "The ARN of the ECS Load Balancer Listener"
  value       = module.load-balancers.lb_ecs_listener_arn
}


# VMs
output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.vms.ec2_instance_id
}

output "ec2_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.vms.ec2_instance_public_ip
}

output "ec2_instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.vms.ec2_instance_private_ip
}

output "ec2_instance_arn" {
  description = "ARN of the EC2 instance"
  value       = module.vms.ec2_instance_arn
}


# Containers
output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.containers.ecs_cluster_id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.containers.ecs_cluster_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.containers.ecs_task_definition_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.containers.ecs_service_name
}

output "ecs_service_id" {
  description = "ID of the ECS service"
  value       = module.containers.ecs_service_id
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.containers.ecs_execution_role_arn
}

output "ecs_security_group_id" {
  description = "ID of the security group used by the ECS service"
  value       = module.containers.ecs_security_group_id
}


# Logs
output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group for ECS task logs"
  value       = module.logs.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for ECS task logs"
  value       = module.logs.cloudwatch_log_group_arn
}
