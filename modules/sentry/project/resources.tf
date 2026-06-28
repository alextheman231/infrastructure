resource "sentry_project" "default" {
  organization = var.organisation_id
  name         = var.name
  teams        = var.teams
  platform     = var.platform
}

resource "sentry_key" "default" {
  organization = var.organisation_id
  project      = sentry_project.default.name
  name         = "DSN-Terraform"
}
