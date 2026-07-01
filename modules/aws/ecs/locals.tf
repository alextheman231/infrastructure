locals {
  network_configuration = {
    security_groups  = toset([aws_security_group.ecs.id])
    subnets          = var.subnet_ids
    assign_public_ip = true
  }
}
