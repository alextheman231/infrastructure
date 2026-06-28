terraform {
  required_providers {
    sentry = {
      source  = "jianyuan/sentry"
      version = ">=0.14.3"
    }
  }
}

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
