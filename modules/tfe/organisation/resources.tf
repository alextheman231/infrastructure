resource "tfe_organization" "default" {
  name  = var.organisation_name
  email = var.email
}
