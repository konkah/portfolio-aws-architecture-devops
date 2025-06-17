resource "aws_ecs_cluster" "portfolio_api_cluster" {
  name = "portfolio-api-cluster"
}

resource "aws_ecs_task_definition" "portfolio_api_task" {
  family                   = "portfolio-api-task"
  container_definitions = jsonencode([
    {
      name      = "portfolio-api-task",
      image     = var.ECS_CONTAINERS_IMAGE_URL,
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ],
      memory = 512,
      cpu    = 256,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.ECS_LOG_GROUP_NAME,
          awslogs-region        = var.ECS_AWS_REGION,
          awslogs-stream-prefix = "portfolio-api"
        }
      }
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "${aws_iam_role.portfolio_api_ecs_task_role.arn}"
}

resource "aws_ecs_service" "portfolio_api_ecs_service" {
  name            = "portfolio-api-ecs-service"
  cluster         = aws_ecs_cluster.portfolio_api_cluster.id
  task_definition = "${aws_ecs_task_definition.portfolio_api_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 2

  load_balancer {
    target_group_arn = var.ECS_LB_TARGET_GROUP_ARN
    container_name   = "${aws_ecs_task_definition.portfolio_api_task.family}"
    container_port   = 80
  }

  network_configuration {
    subnets          = var.ECS_PRIVATE_SUBNET_ID_LIST
    assign_public_ip = false     # Provide the containers with public IPs
    security_groups  = ["${aws_security_group.portfolio_api_security_group.id}"] # Set up the security group
  }
}

resource "aws_iam_role" "portfolio_api_ecs_task_role" {
  name               = "portfolio-api-ecs-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.portfolio_api_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ecs_task_portfolio_api_role_policy" {
  role       = "${aws_iam_role.portfolio_api_ecs_task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "portfolio_api_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_security_group" "portfolio_api_security_group" {
  name   = "portfolio-api-security-group"
  vpc_id = var.ECS_VPC_ID

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = var.ECS_LB_SECURITY_GROUP_LIST
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
