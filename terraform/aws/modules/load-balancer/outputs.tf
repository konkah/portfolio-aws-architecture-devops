output "lb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_alb.portfolio_api_load_balancer.arn
}

output "lb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_alb.portfolio_api_load_balancer.dns_name
}

output "lb_security_group_id" {
  description = "The security group ID associated with the Load Balancer"
  value       = aws_security_group.portfolio_api_lb_security_group.id
}

output "lb_target_group_arn" {
  description = "The ARN of the Load Balancer Target Group"
  value       = aws_lb_target_group.portfolio_api_lb_target_group.arn
}

output "lb_listener_arn" {
  description = "The ARN of the Load Balancer Listener"
  value       = aws_lb_listener.portfolio_api_lb_listener.arn
}
