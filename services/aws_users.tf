module "alex_iam_user" {
  source = "../modules/aws/iam/users/power_user"

  name = "alextheman231"
}

module "alex_iam_read_only_user" {
  source = "../modules/aws/iam/users/read_only_user"

  name = "alextheman231_readonly"
}
