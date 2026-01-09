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
  billing_email                   = var.billing_email
  name                            = data.github_organization.default.name
  description                     = "This GitHub organisation is home to all my mainline NPM packages, shared GitHub Actions, Infrastructure, and applications."
  default_repository_permission   = "read"
  members_can_create_repositories = false
}

resource "github_actions_organization_secret" "alex_up_bot_github_token" {
  secret_name     = "ALEX_UP_BOT_GITHUB_TOKEN"
  plaintext_value = var.alex_up_bot_github_token
  visibility      = "all"
}

resource "github_organization_webhook" "default" {
  configuration {
    url          = var.webhook_url
    content_type = "json"
  }

  active = true

  events = ["push", "issues"]
}
