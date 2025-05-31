output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group for ECS task logs"
  value       = aws_cloudwatch_log_group.portfolio_api_logs.name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for ECS task logs"
  value       = aws_cloudwatch_log_group.portfolio_api_logs.arn
}
