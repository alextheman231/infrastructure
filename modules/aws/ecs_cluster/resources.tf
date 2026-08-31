resource "aws_ecs_cluster" "default" {
  name = var.name
}

resource "aws_ecs_task_definition" "task" {
  for_each = var.task_definitions

  family                   = "${var.name}-${each.key}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    merge({
      name  = "${var.name}-${each.key}"
      image = var.image

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
      },
      each.value.port == null ? {} : {
        portMappings = [
          {
            protocol      = "tcp"
            containerPort = each.value.port
            hostPort      = each.value.port
          }
        ]
      }
    )
  ])
}

resource "aws_cloudwatch_log_group" "default" {
  name              = var.name
  retention_in_days = 30
}

resource "aws_ecs_service" "default" {
  for_each = {
    for key, task in var.task_definitions :
    key => task
    if task.is_long_running
  }

  name            = "${var.name}-${each.key}"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.task[each.key].arn

  desired_count = 1

  launch_type      = "FARGATE"
  platform_version = var.fargate_version

  network_configuration {
    security_groups  = local.network_configuration.security_groups
    subnets          = local.network_configuration.subnets
    assign_public_ip = local.network_configuration.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = (
      each.value.target_group_arn != null &&
      each.value.port != null
    ) ? [each.value] : []
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = "${var.name}-${each.key}"
      container_port   = load_balancer.value.port
    }
  }
}
