# EC2
output "lb_ec2_arn" {
  description = "The ARN of the ec2 Application Load Balancer"
  value       = aws_alb.portfolio_api_lb_ec2.arn
}

output "lb_ec2_dns_name" {
  description = "The DNS name of the ec2 Application Load Balancer"
  value       = aws_alb.portfolio_api_lb_ec2.dns_name
}

output "lb_ec2_security_group_id" {
  description = "The security group ID associated with the ec2 Load Balancer"
  value       = aws_security_group.portfolio_api_lb_ec2_security_group.id
}

output "lb_ec2_target_group_arn" {
  description = "The ARN of the ec2 Load Balancer Target Group"
  value       = aws_lb_target_group.portfolio_api_lb_ec2_target_group.arn
}

output "lb_ec2_listener_arn" {
  description = "The ARN of the ec2 Load Balancer Listener"
  value       = aws_lb_listener.portfolio_api_lb_ec2_listener.arn
}


# ECS
output "lb_ecs_arn" {
  description = "The ARN of the ECS Application Load Balancer"
  value       = aws_alb.portfolio_api_lb_ecs.arn
}

output "lb_ecs_dns_name" {
  description = "The DNS name of the ECS Application Load Balancer"
  value       = aws_alb.portfolio_api_lb_ecs.dns_name
}

output "lb_ecs_security_group_id" {
  description = "The security group ID associated with the ECS Load Balancer"
  value       = aws_security_group.portfolio_api_lb_ecs_security_group.id
}

output "lb_ecs_target_group_arn" {
  description = "The ARN of the ECS Load Balancer Target Group"
  value       = aws_lb_target_group.portfolio_api_lb_ecs_target_group.arn
}

output "lb_ecs_listener_arn" {
  description = "The ARN of the ECS Load Balancer Listener"
  value       = aws_lb_listener.portfolio_api_lb_ecs_listener.arn
}
