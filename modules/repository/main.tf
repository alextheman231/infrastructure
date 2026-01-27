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

resource "github_repository_ruleset" "linear_history" {
  name        = "Require linear history on all branches"
  repository  = github_repository.default.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    required_linear_history = true
    non_fast_forward        = false # Allow force-pushes
  }
}

resource "github_repository_ruleset" "ci_checks" {
  count       = length(var.required_ci_checks) > 0 ? 1 : 0
  name        = "CI checks to run on main"
  repository  = github_repository.default.name
  target      = "branch"
  enforcement = "active"

  bypass_actors {
    actor_type  = "OrganizationAdmin"
    bypass_mode = "pull_request"
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
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

resource "github_repository_ruleset" "pull_request_conditions" {
  name        = "Pull request conditions (bypassable by admins)"
  repository  = github_repository.default.name
  target      = "branch"
  enforcement = "active"

  bypass_actors {
    actor_type  = "OrganizationAdmin"
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
      dismiss_stale_reviews_on_push   = true
      require_code_owner_review       = true
    }
  }
}

resource "github_repository_ruleset" "restrict_version_tags" {
  name        = "Restriction against creating version tags (bypassable by alex-up-bot)"
  repository  = github_repository.default.name
  target      = "tag"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/tags/*"]
      exclude = []
    }
  }

  bypass_actors {
    actor_type  = "Integration"
    actor_id    = var.alex_up_bot_app_id
    bypass_mode = "exempt"
  }

  rules {
    creation = true
    update   = true
    deletion = true

    tag_name_pattern {
      operator = "regex"
      name     = "Version numbers"
      pattern  = "^(?:v)?(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)$"
    }
  }
}
