terraform {
  required_version = ">= 1.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_repository" "default" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = var.has_issues
  has_projects = var.has_projects
  has_wiki     = var.has_wiki

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_rebase_merge     = true
  allow_squash_merge     = false
  delete_branch_on_merge = true

  archived = var.archived

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_ruleset" "default" {
  count       = length(var.required_ci_checks) > 0 ? 1 : 0
  name        = "Main branch protection"
  repository  = github_repository.default.name
  target      = "branch"
  enforcement = "active"

  bypass_actors {
    actor_type  = "OrganizationAdmin"
    actor_id    = "1"
    bypass_mode = "always"
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    pull_request {
      required_approving_review_count = 0
    }
    required_status_checks {
      strict_required_status_checks_policy = true

      dynamic "required_check" {
        for_each = distinct(var.required_ci_checks)
        content {
          context = required_check.value
        }
      }
    }
  }
}

resource "github_actions_secret" "alex_up_bot_github_token" {
  repository      = github_repository.default.name
  secret_name     = "ALEX_UP_BOT_GITHUB_TOKEN"
  plaintext_value = var.alex_up_bot_github_token
}
