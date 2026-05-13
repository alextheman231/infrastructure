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
  teams        = [var.organisation_name]
  platform     = var.platform
}
