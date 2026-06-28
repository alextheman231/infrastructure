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

resource "github_repository_pages" "default" {
  count      = var.has_pages && !var.archived ? 1 : 0
  repository = github_repository.default.name
  build_type = "workflow"
}

resource "github_actions_repository_permissions" "default" {
  count                = !var.archived ? 1 : 0
  repository           = github_repository.default.name
  allowed_actions      = "all"
  sha_pinning_required = true
}
