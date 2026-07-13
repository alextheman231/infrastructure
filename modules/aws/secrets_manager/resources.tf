resource "aws_secretsmanager_secret" "default" {
  name = var.name
}

resource "aws_secretsmanager_secret_version" "default" {
  secret_id = aws_secretsmanager_secret.default.id
  secret_string = jsonencode({
    for key, value in var.secrets :
    key => sensitive(value)
  })
}
