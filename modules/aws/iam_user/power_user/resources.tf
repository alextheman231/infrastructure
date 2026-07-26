resource "aws_iam_user" "power_user" {
  name = var.name
  path = "/"
}

resource "aws_iam_user_login_profile" "power_user" {
  user = aws_iam_user.power_user.name
}


data "aws_iam_policy" "power_user_access" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user_policy_attachment" "power_user" {
  policy_arn = data.aws_iam_policy.power_user_access.arn
  user       = aws_iam_user.power_user.name
}
