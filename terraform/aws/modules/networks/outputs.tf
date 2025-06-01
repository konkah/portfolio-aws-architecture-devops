output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.portfolio_api_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = aws_vpc.portfolio_api_vpc.cidr_block
}

output "vpc_public_subnet_id_list" {
  description = "List of public subnet IDs"
  value       = [
    aws_subnet.portfolio_api_subnet_1.id,
    aws_subnet.portfolio_api_subnet_2.id
  ]
}

output "vpc_availability_zone_list" {
  description = "List of availability zones used for subnets"
  value       = [
    aws_subnet.portfolio_api_subnet_1.availability_zone,
    aws_subnet.portfolio_api_subnet_2.availability_zone
  ]
}

output "vpc_internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.portfolio_api_internet_gateway.id
}

output "vpc_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.portfolio_api_route_table.id
}
