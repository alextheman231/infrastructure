resource "aws_iam_role" "role" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.terraform_assume_role.json
}

resource "aws_iam_role_policy" "role" {
  role   = aws_iam_role.role.id
  policy = var.policy_json
}

output "role_arn" {
  value = aws_iam_role.role.arn
}
