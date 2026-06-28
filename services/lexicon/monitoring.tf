module "lexicon_sentry_back_end" {
  source          = "../../modules/sentry/project"
  name            = "lexicon-back-end"
  organisation_id = var.sentry_organisation_id
  platform        = "node-express"
  teams           = ["alextheman231"]
}

module "lexicon_sentry_front_end" {
  source          = "../../modules/sentry/project"
  organisation_id = var.sentry_organisation_id
  teams           = ["alextheman231"]
  name            = "lexicon-front-end"
  platform        = "javascript-react"
}
