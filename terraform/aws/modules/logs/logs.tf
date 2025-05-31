resource "aws_cloudwatch_log_group" "portfolio_api_logs" {
  name = "portfolio-api-logs"
  retention_in_days = 7
  tags = {
    Application = "Portfolio API"
  }
}
