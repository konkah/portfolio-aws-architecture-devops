resource "aws_vpc" "portfolio_api_vpc" {
  cidr_block = var.VPC_IP
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "portfolio_api_subnet_1" {
  availability_zone = var.VPC_AWS_ZONE_1
  vpc_id = aws_vpc.portfolio_api_vpc.id
  cidr_block = var.VPC_SUBNET1_IP
}

resource "aws_subnet" "portfolio_api_subnet_2" {
  availability_zone = var.VPC_AWS_ZONE_2
  vpc_id = aws_vpc.portfolio_api_vpc.id
  cidr_block = var.VPC_SUBNET2_IP
}

resource "aws_internet_gateway" "portfolio_api_internet_gateway" {
  vpc_id = aws_vpc.portfolio_api_vpc.id
}

resource "aws_route_table" "portfolio_api_route_table" {
  vpc_id = aws_vpc.portfolio_api_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.portfolio_api_internet_gateway.id
  }
}

resource "aws_main_route_table_association" "portfolio_api_main" {
  vpc_id         = aws_vpc.portfolio_api_vpc.id
  route_table_id = aws_route_table.portfolio_api_route_table.id
}

resource "aws_route_table_association" "portfolio_api_table_1" {
  subnet_id = aws_subnet.portfolio_api_subnet_1.id
  route_table_id = aws_route_table.portfolio_api_route_table.id
}

resource "aws_route_table_association" "portfolio_api_table_2" {
  subnet_id = aws_subnet.portfolio_api_subnet_2.id
  route_table_id = aws_route_table.portfolio_api_route_table.id
}
