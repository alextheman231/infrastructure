output "role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "role_id" {
  value = aws_iam_role.ecs_task_execution.id
}
