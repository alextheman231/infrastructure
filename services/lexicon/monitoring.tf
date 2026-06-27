module "lexicon_sentry_back_end" {
  source   = "../../modules/sentry/project"
  name     = "lexicon-back-end"
  platform = "node-express"
}

module "lexicon_sentry_front_end" {
  source   = "../../modules/sentry/project"
  name     = "lexicon-front-end"
  platform = "javascript-react"
}
