output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = aws_ecr_repository.portfolio_api_container_hub.name
}

output "ecr_repository_url" {
  description = "The full ECR repository URL (without tag)"
  value       = aws_ecr_repository.portfolio_api_container_hub.repository_url
}

output "ecr_repository_url_version" {
  description = "The full ECR repository URL (with tag)"
  value       = "${aws_ecr_repository.portfolio_api_container_hub.repository_url}:${var.ECR_APP_VERSION}"
}

output "ecr_account_id" {
  description = "AWS Account ID used for ECR"
  value       = data.aws_caller_identity.portfolio_api_current.account_id
}
