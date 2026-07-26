resource "aws_iam_user" "default" {
  name = var.name
  path = "/"
}

resource "aws_iam_user_login_profile" "default" {
  user = aws_iam_user.default.name
}
