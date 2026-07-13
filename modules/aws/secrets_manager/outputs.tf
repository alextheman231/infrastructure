output "arn" {
  description = "ARN of the secret."
  value       = aws_secretsmanager_secret.default.arn
}

output "secret_arns" {
  description = "Mapping of secret names to the Secrets Manager ARN containing them."
  value = {
    for name in keys(var.secrets) :
    name => aws_secretsmanager_secret.default.arn
  }
}
