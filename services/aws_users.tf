module "alex_iam_user" {
  source = "../modules/aws/iam_user/power_user"

  name = "alextheman231"
}

module "alex_iam_read_only_user" {
  source = "../modules/aws/iam_user/read_only_user"

  name = "alextheman231_readonly"
}
