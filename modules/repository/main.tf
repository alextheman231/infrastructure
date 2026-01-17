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

resource "github_repository_ruleset" "ci_checks" {
  count       = length(var.required_ci_checks) > 0 ? 1 : 0
  name        = "CI checks to run on main"
  repository  = github_repository.default.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
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
        merge_method = "MERGE"
      }
    }
  }
}

resource "github_repository_ruleset" "pull_request_reviews" {
  name        = "Pull request review conditions (bypassable by admins)"
  repository  = github_repository.default.name
  target      = "branch"
  enforcement = "active"

  bypass_actors {
    actor_type  = "OrganizationAdmin"
    actor_id    = 1
    bypass_mode = "exempt"
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    pull_request {
      required_approving_review_count = 1
    }
  }
}
