terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
}

data "aws_ssoadmin_instances" "default" {}

locals {
  identity_center_instance_arn = tolist(
    data.aws_ssoadmin_instances.default.arns
  )[0]

  identity_store_id = tolist(
    data.aws_ssoadmin_instances.default.identity_store_ids
  )[0]
}

resource "aws_ssoadmin_permission_set" "administrator" {
  instance_arn = local.identity_center_instance_arn

  name             = "AdministratorAccess"
  description      = "Full administrative access."
  session_duration = "PT12H"
}
