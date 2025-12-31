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
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true

  archived = var.archived
}

resource "github_branch_protection" "main" {
  count         = var.enable_branch_protection ? 1 : 0
  repository_id = github_repository.default.name
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = var.required_ci_checks
  }

  required_pull_request_reviews {
    required_approving_review_count = 0
  }

}
