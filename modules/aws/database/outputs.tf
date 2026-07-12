output "endpoint" {
  value = aws_db_instance.default.endpoint
}

output "database_url" {
  sensitive = true
  value     = "postgresql://${var.username}:${var.password}@${aws_db_instance.default.address}:5432/${var.initial_db_name}"
}

output "postgres_version" {
  value = aws_db_instance.default.engine_version
}

output "address" {
  value = aws_db_instance.default.address
}

output "port" {
  value = aws_db_instance.default.port
}

output "db_name" {
  value = aws_db_instance.default.db_name
}

output "username" {
  value = aws_db_instance.default.username
}

