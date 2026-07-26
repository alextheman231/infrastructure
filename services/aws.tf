locals {
  aws_region = "eu-west-2"
}

module "alex_iam_user" {
  source = "../modules/aws/iam_user/power_user"

  name = "alextheman231"
}

moved {
  from = module.alex_iam_user.aws_iam_user.default
  to   = module.alex_iam_user.aws_iam_user.power_user
}

moved {
  from = module.alex_iam_user.aws_iam_user_login_profile.default
  to   = module.alex_iam_user.aws_iam_user_login_profile.power_user
}
