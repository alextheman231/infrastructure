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

resource "github_organization_webhook" "default" {
  configuration {
    url          = var.webhook_url
    content_type = "json"
  }

  active = true

  events = ["push", "issues", "release"]
}

resource "github_actions_organization_secret" "default" {
  for_each        = nonsensitive(var.secrets)
  secret_name     = each.key
  value_encrypted = each.value
  visibility      = "all"
}

resource "github_actions_organization_variable" "default" {
  for_each      = var.variables
  variable_name = each.key
  value         = each.value
  visibility    = "all"
}

resource "github_membership" "admins" {
  for_each = toset(var.admins)

  username = each.value
  role     = "admin"
}

resource "github_membership" "members" {
  for_each = toset(var.members)

  username = each.value
  role     = "member"
}
