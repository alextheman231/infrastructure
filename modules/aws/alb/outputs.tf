output "target_group_arn" {
  value = aws_lb_target_group.default.arn
}

output "listener_arn" {
  value = aws_lb_listener.https.arn
}

output "dns_name" {
  value = aws_lb.default.dns_name
}

output "zone_id" {
  value = aws_lb.default.zone_id
}
