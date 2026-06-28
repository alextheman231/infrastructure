resource "aws_iam_role" "role" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.terraform_assume_role.json
}

resource "aws_iam_role_policy" "role" {
  count = var.policy_json == null ? 0 : 1

  role   = aws_iam_role.role.id
  policy = var.policy_json
}
