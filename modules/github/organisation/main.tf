terraform {
  required_version = ">= 1.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
  }
}

resource "github_organization_settings" "default" {
  billing_email                           = var.billing_email
  name                                    = var.name
  description                             = var.description
  default_repository_permission           = "write"
  members_can_create_public_repositories  = false
  members_can_create_private_repositories = false

  lifecycle {
    ignore_changes = [members_can_create_repositories]
  }
}
