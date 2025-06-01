output "cloudwatch_log_ec2_group_name" {
  description = "Name of the CloudWatch Log Group for EC2 task logs"
  value       = aws_cloudwatch_log_group.portfolio_api_ec2_logs.name
}

output "cloudwatch_log_ec2_group_arn" {
  description = "ARN of the CloudWatch Log Group for EC2 task logs"
  value       = aws_cloudwatch_log_group.portfolio_api_ec2_logs.arn
}

output "cloudwatch_log_ecs_group_name" {
  description = "Name of the CloudWatch Log Group for ECS task logs"
  value       = aws_cloudwatch_log_group.portfolio_api_ecs_logs.name
}

output "cloudwatch_log_ecs_group_arn" {
  description = "ARN of the CloudWatch Log Group for ECS task logs"
  value       = aws_cloudwatch_log_group.portfolio_api_ecs_logs.arn
}
