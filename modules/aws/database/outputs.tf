output "endpoint" {
  value = aws_db_instance.default.endpoint
}

output "database_url" {
  sensitive = true
  value     = "postgresql://${var.username}:${var.password}@${aws_db_instance.default.address}:5432/${var.initial_db_name}"
}
