module "lexicon_repository" {
  source      = "../modules/github/repository"
  name        = "lexicon"
  description = "The true successor to Neurosongs, allowing users to write blogs and share them, with a dynamic editor."
  visibility  = "public"
  required_ci_checks = concat(local.check_list.base, [
    local.check_name.lexicon.lint_ci,
    local.check_name.lexicon.test_ci,
    local.check_name.lexicon.end_to_end_ci
  ])
  alex_up_bot_app_id = var.alex_up_bot_app_id
  secrets = {
    VERCEL_TOKEN      = var.vercel_api_token_lexicon_github
    RENDER_DEPLOY_KEY = var.lexicon_render_key
    DATABASE_URL      = var.lexicon_database_url_encrypted
    DOCKER_PAT        = var.docker_pat_lexicon_encrypted
  }
  variables = {
    VITE_API_BASE_URL    = var.lexicon_api_base_url
    VERCEL_ORG_ID        = var.vercel_team_id
    VERCEL_PROJECT_ID    = var.lexicon_vercel_project_id
    RENDER_SERVICE_ID    = var.lexicon_render_service_id
    DOCKER_USERNAME      = var.docker_username
    FRONT_END_SENTRY_DSN = var.lexicon_front_end_sentry_dsn
  }
}

module "lexicon_database" {
  source                = "../modules/neon"
  name                  = "Lexicon"
  org_id                = var.neon_organisation_id
  pg_version            = 17
  default_database_name = "lexicon-prod"
}

module "lexicon_database_v18" {
  source                = "../modules/neon"
  name                  = "Lexicon"
  org_id                = var.neon_organisation_id
  pg_version            = 18
  default_database_name = "lexicon-prod"
}

module "lexicon_server" {
  source         = "../modules/render"
  name           = "Lexicon"
  repository_url = var.lexicon_repository_url
  docker_image   = "${var.docker_username}/lexicon"
  secrets = {
    DATABASE_URL         = var.lexicon_database_url
    NODE_ENV             = "production"
    API_BASE_URL         = var.lexicon_api_base_url
    ALLOWED_ORIGINS      = "https://${var.lexicon_domain}"
    GOOGLE_CLIENT_ID     = var.lexicon_google_client_id
    GOOGLE_CLIENT_SECRET = var.lexicon_google_client_secret
    SENTRY_DSN           = var.lexicon_back_end_sentry_dsn
  }
}

module "lexicon_image" {
  source      = "../modules/docker"
  namespace   = var.docker_username
  name        = "lexicon"
  description = "Dockerhub repository for the Lexicon back-end server image."
}

module "lexicon_project" {
  source           = "../modules/vercel/project"
  vercel_team_id   = var.vercel_team_id
  name             = "lexicon-front-end"
  framework        = "vite"
  output_directory = "apps/front-end/dist"
  domain           = var.lexicon_domain
}

module "lexicon_sentry_back_end" {
  source   = "../modules/sentry/project"
  name     = "lexicon-back-end"
  platform = "node-express"
}

module "lexicon_sentry_front_end" {
  source   = "../modules/sentry/project"
  name     = "lexicon-front-end"
  platform = "javascript-react"
}
