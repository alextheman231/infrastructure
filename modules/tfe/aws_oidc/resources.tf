resource "tfe_aws_oidc_configuration" "default" {
  role_arn     = var.role_arn
  organization = var.organisation_name
}
