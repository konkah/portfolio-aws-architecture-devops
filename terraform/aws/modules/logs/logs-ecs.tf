resource "aws_cloudwatch_log_group" "portfolio_api_ecs_logs" {
  name = "portfolio-api-ecs-logs"
  retention_in_days = 7
  tags = {
    Application = "Portfolio ECS API"
  }
}
