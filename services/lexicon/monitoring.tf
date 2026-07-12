resource "sentry_organization_repository" "github" {
  organization     = var.sentry_organisation_id
  integration_type = "github"
  integration_id   = var.sentry_github_integration_id
  identifier       = "lexicon"
}

module "lexicon_sentry_back_end" {
  source                = "../../modules/sentry/project"
  name                  = "lexicon-back-end"
  organisation_id       = var.sentry_organisation_id
  platform              = "node-express"
  teams                 = ["alextheman231"]
  github_integration_id = var.sentry_github_integration_id
  sentry_repository_id  = sentry_organization_repository.github.id
  source_root           = "apps/back-end/src"
}

module "lexicon_sentry_front_end" {
  source                = "../../modules/sentry/project"
  organisation_id       = var.sentry_organisation_id
  teams                 = ["alextheman231"]
  name                  = "lexicon-front-end"
  platform              = "javascript-react"
  github_integration_id = var.sentry_github_integration_id
  sentry_repository_id  = sentry_organization_repository.github.id
  source_root           = "apps/front-end/src"
}
