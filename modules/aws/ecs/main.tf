terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.name}-ecs-task-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "ecs" {
  name   = "${var.name}-ecs"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.ecs.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_ecs_cluster" "default" {
  name = var.name
}

resource "aws_ecs_task_definition" "default" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name  = var.name
      image = var.image

      portMappings = [{
        containerPort = var.port
      }]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.default.name
          awslogs-region        = "eu-north-1"
          awslogs-stream-prefix = var.name
        }
      }

      environment = [
        for key, value in nonsensitive(var.environment_variables) : {
          name  = key
          value = value
        }
      ]
    }
  ])
}

resource "aws_cloudwatch_log_group" "default" {
  name              = var.name
  retention_in_days = 30
}

resource "aws_ecs_service" "default" {
  name            = var.name
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.default.arn

  desired_count = 1

  launch_type      = "FARGATE"
  platform_version = var.fargate_version

  network_configuration {
    security_groups  = toset([aws_security_group.ecs.id])
    subnets          = data.aws_subnets.default.ids
    assign_public_ip = true
  }
}

output "security_group_id" {
  value = aws_security_group.ecs.id
}
