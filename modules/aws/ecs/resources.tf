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

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.ecs.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_ecs_cluster" "default" {
  name = var.name
}

resource "aws_ecs_task_definition" "task" {
  for_each = {
    for task in var.task_definitions :
    task.name => task
  }

  family                   = "${var.name}-${each.key}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    merge({
      name  = "${var.name}-${each.value.name}"
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
      },
      each.value.command == null ? {} : {
        command = each.value.command
      }
    )
  ])
}

resource "aws_cloudwatch_log_group" "default" {
  name              = var.name
  retention_in_days = 30
}

resource "aws_ecs_service" "default" {
  name            = var.name
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.task["service"].arn

  desired_count = 1

  launch_type      = "FARGATE"
  platform_version = var.fargate_version

  network_configuration {
    security_groups  = local.network_configuration.security_groups
    subnets          = local.network_configuration.subnets
    assign_public_ip = local.network_configuration.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.name}-service"
    container_port   = var.port
  }
}
