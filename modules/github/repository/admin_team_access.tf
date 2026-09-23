resource "github_team_repository" "admins" {
  team_id    = var.admin_team_id
  repository = github_repository.default.name
  permission = "push"
}
