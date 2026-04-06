terraform {
  required_version = ">= 1.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

data "github_organization" "default" {
  name = "alextheman231"
}

resource "github_organization_settings" "default" {
  billing_email                           = var.billing_email
  name                                    = data.github_organization.default.name
  description                             = "This GitHub organisation is home to all my mainline NPM packages, shared GitHub Actions, Infrastructure, and applications."
  default_repository_permission           = "write"
  members_can_create_public_repositories  = false
  members_can_create_private_repositories = false

  lifecycle {
    ignore_changes = [members_can_create_repositories]
  }
}

resource "github_organization_webhook" "default" {
  configuration {
    url          = var.webhook_url
    content_type = "json"
  }

  active = true

  events = ["push", "issues", "release"]
}
