resource "aws_iam_user" "read_only" {
  name = var.name
  path = "/"
}

resource "aws_iam_user_login_profile" "read_only" {
  user = aws_iam_user.read_only.name
}


data "aws_iam_policy" "read_only_access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "read_only" {
  policy_arn = data.aws_iam_policy.read_only_access.arn
  user       = aws_iam_user.read_only.name
}
