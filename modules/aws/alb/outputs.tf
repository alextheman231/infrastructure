output "security_group_id" {
  value = aws_security_group.alb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.default.arn
}

output "listener_arn" {
  value = aws_lb_listener.default.arn
}
