output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.portfolio_api_cluster.id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.portfolio_api_cluster.name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.portfolio_api_task.arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.portfolio_api_ecs_service.name
}

output "ecs_service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.portfolio_api_ecs_service.id
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.portfolio_api_ecs_task_role.arn
}

output "ecs_security_group_id" {
  description = "ID of the security group used by the ECS service"
  value       = aws_security_group.portfolio_api_security_group.id
}
