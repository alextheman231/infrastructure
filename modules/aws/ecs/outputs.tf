output "security_group_id" {
  value = aws_security_group.ecs.id
}

output "cluster_name" {
  value = aws_ecs_cluster.default.name
}

output "service_name" {
  value = aws_ecs_service.default.name
}

output "task_families" {
  value = {
    for name, task in aws_ecs_task_definition.task :
    name => task.family
  }
}

output "subnet_ids" {
  value = local.network_configuration.subnets
}

output "assign_public_ip" {
  value = local.network_configuration.assign_public_ip
}
