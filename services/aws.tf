locals {
  aws_region = "eu-north-1"
}

module "aws_repository" {
  source       = "../modules/aws"
  instance_arn = var.aws_instance_arn
}
