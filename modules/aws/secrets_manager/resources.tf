resource "aws_secretsmanager_secret" "default" {
  name                    = var.name
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "default" {
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = jsonencode(var.secrets)
}

resource "aws_iam_role_policy" "secret_access" {
  for_each = merge(var.allowed_role_ids, {
    terraform_plan_role = var.plan_role_id
  })

  name = "${each.key}-${var.name}-secrets-access"
  role = each.value

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "secretsmanager:GetSecretValue"
      ]

      Resource = aws_secretsmanager_secret.default.arn
    }]
  })
}
