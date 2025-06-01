output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.portfolio_api_ubuntu_instance.id
}

output "ec2_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.portfolio_api_ubuntu_instance.public_ip
}

output "ec2_instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.portfolio_api_ubuntu_instance.private_ip
}

output "ec2_instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.portfolio_api_ubuntu_instance.arn
}
