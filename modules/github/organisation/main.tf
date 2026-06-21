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

resource "github_issue_label" "low_risk" {
  repository  = var.name
  name        = "low risk"
  color       = "008672"
  description = "Low risk change"
}

resource "github_issue_label" "medium_risk" {
  repository  = var.name
  name        = "medium risk"
  color       = "7057FF"
  description = "Medium risk change"
}

resource "github_issue_label" "high_risk" {
  repository  = var.name
  name        = "high risk"
  color       = "E4E669"
  description = "High risk change"
}

resource "github_issue_label" "low_priority" {
  repository  = var.name
  name        = "low priority"
  color       = "0E8A16"
  description = "Low priority change"
}

resource "github_issue_label" "medium_priority" {
  repository  = var.name
  name        = "medium priority"
  color       = "FBCA04"
  description = "Medium priority change"
}

resource "github_issue_label" "high_priority" {
  repository  = var.name
  name        = "high priority"
  color       = "D73A4A"
  description = "High priority change"
}

resource "github_issue_label" "critical_priority" {
  repository  = var.name
  name        = "critical priority"
  color       = "B60205"
  description = "Critical priority change"
}
