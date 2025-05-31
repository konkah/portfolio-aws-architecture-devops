# ECR
output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = module.image-registry.ecr_repository_name
}

output "ecr_repository_url" {
  description = "The full ECR repository URL (without tag)"
  value       = module.image-registry.ecr_repository_url
}

output "ecr_repository_url_version" {
  description = "The full ECR repository URL (with tag)"
  value       = module.image-registry.ecr_repository_url_version
}

output "ecr_account_id" {
  description = "AWS Account ID used for ECR"
  value       = module.image-registry.ecr_account_id
}

# VPC
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = module.network.vpc_cidr_block
}

output "vpc_public_subnet_id_list" {
  description = "List of public subnet IDs"
  value       = module.network.vpc_public_subnet_id_list
}

output "vpc_availability_zone_list" {
  description = "List of availability zones used for subnets"
  value       = module.network.vpc_availability_zone_list
}

output "vpc_internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.network.vpc_internet_gateway_id
}

output "vpc_route_table_id" {
  description = "ID of the public route table"
  value       = module.network.vpc_route_table_id
}

# Load Balancer
output "lb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.load-balancer.lb_arn
}

output "lb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.load-balancer.lb_dns_name
}

output "lb_security_group_id" {
  description = "The security group ID associated with the Load Balancer"
  value       = module.load-balancer.lb_security_group_id
}

output "lb_target_group_arn" {
  description = "The ARN of the Load Balancer Target Group"
  value       = module.load-balancer.lb_target_group_arn
}

output "lb_listener_arn" {
  description = "The ARN of the Load Balancer Listener"
  value       = module.load-balancer.lb_listener_arn
}

# ECS
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

#Logs
output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group for ECS task logs"
  value       = module.logs.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for ECS task logs"
  value       = module.logs.cloudwatch_log_group_arn
}
