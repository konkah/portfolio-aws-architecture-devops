resource "aws_alb" "portfolio_api_load_balancer" {
  name               = "portfolio-api-load-balancer-prod"
  load_balancer_type = "application"
  subnets            = var.LB_SUBNET_ID_LIST
  security_groups    = ["${aws_security_group.portfolio_api_lb_security_group.id}"]
}

resource "aws_security_group" "portfolio_api_lb_security_group" {
  name   = "portfolio-api-lb-sg"
  vpc_id = var.LB_VPC_ID
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "portfolio_api_lb_target_group" {
  name        = "portfolio-api-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.LB_VPC_ID
}

resource "aws_lb_listener" "portfolio_api_lb_listener" {
  load_balancer_arn  = "${aws_alb.portfolio_api_load_balancer.arn}"
  port               = "80"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.portfolio_api_lb_target_group.arn}"
  }
}
