locals {
  aws_region = "eu-west-2"
}

module "alex_iam_user" {
  source = "../modules/aws/iam_user/power_user"

  name = "alextheman231"
}
