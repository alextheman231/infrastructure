terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.76.1"
    }
  }
}

data "tfe_organization" "self" {
  name = var.organisation_name
}

resource "tfe_organization" "default" {
  name  = var.organisation_name
  email = var.email
}

resource "tfe_organization_default_settings" "org_default" {
  organization           = tfe_organization.default.name
  default_execution_mode = "remote"
}
