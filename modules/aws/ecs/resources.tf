resource "aws_security_group" "ecs" {
  name   = "${var.name}-ecs"
  vpc_id = var.vpc_id

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

  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    merge({
      name  = "${var.name}-${each.value.name}"
      image = "${var.image}:latest"

      portMappings = [{
        containerPort = var.port
      }]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.default.name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.name
        }
      }

      essential = true

      environment = [
        for key, value in var.environment_variables : {
          name  = key
          value = value
        }
      ]
      },
      length(var.secret_arns) == 0 ? {} : {
        secrets = [
          for key, arn in var.secret_arns : {
            name      = key
            valueFrom = "${arn}:${key}::"
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
