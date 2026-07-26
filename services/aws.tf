locals {
  aws_region = "eu-west-2"
}

module "alex_iam_user" {
  source = "../modules/aws/iam_user"

  name = "alextheman231"
}

data "aws_iam_policy" "power_user_access" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user_policy_attachment" "power_user" {
  policy_arn = data.aws_iam_policy.power_user_access.arn
  user       = module.alex_iam_user.name
}
