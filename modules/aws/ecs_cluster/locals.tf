locals {
  network_configuration = {
    security_groups  = toset(var.security_group_ids)
    subnets          = var.subnet_ids
    assign_public_ip = var.assign_public_ip
  }
}
