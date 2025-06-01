resource "aws_cloudwatch_log_group" "portfolio_api_ec2_logs" {
  name = "portfolio-api-ec2-logs"
  retention_in_days = 7
  tags = {
    Application = "Portfolio EC2 API"
  }
}
