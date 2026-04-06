terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.76.1"
    }
  }
}

resource "tfe_organization" "default" {
  name  = var.organisation_name
  email = var.email
}
