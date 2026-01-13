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

  allow_update_branch = true

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
    actor_type  = "RepositoryRole"
    actor_id    = "5"
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
      strict_required_status_checks_policy = !var.enable_merge_queue

      dynamic "required_check" {
        for_each = distinct(var.required_ci_checks)
        content {
          context = required_check.value
        }
      }
    }

    dynamic "merge_queue" {
      for_each = var.enable_merge_queue ? [1] : []
      content {
        merge_method                      = "MERGE"
        min_entries_to_merge              = 2
        min_entries_to_merge_wait_minutes = 1
      }
    }
  }
}
