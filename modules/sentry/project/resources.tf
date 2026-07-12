resource "sentry_project" "default" {
  organization = var.organisation_id
  name         = var.name
  teams        = var.teams
  platform     = var.platform
}

resource "sentry_organization_code_mapping" "default" {
  organization   = var.organisation_id
  integration_id = var.github_integration_id
  repository_id  = var.sentry_repository_id
  project_id     = sentry_project.default.internal_id

  default_branch = "main"
  stack_root     = "/"
  source_root    = var.source_root
}

resource "sentry_key" "default" {
  organization = var.organisation_id
  project      = sentry_project.default.name
  name         = "DSN-Terraform"
}
