locals {
  aws_region = "eu-north-1"
}

module "aws_repository" {
  source       = "../modules/aws/admin_permission_set"
  instance_arn = var.aws_instance_arn
}
