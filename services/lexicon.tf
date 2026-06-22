module "lexicon_repository" {
  source      = "../modules/github/repository"
  name        = "lexicon"
  description = "The true successor to Neurosongs, allowing users to write blogs, share them, and track revision history."
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
    VITE_API_BASE_URL    = "https://${var.lexicon_api_domain}"
    VERCEL_ORG_ID        = var.vercel_team_id
    VERCEL_PROJECT_ID    = var.lexicon_vercel_project_id
    RENDER_SERVICE_ID    = var.lexicon_render_service_id
    DOCKER_USERNAME      = var.docker_username
    FRONT_END_SENTRY_DSN = var.lexicon_front_end_sentry_dsn
  }
  labels = merge(local.labels.standard, local.labels.app)
}

module "lexicon_database" {
  source                = "../modules/neon"
  name                  = "Lexicon"
  org_id                = var.neon_organisation_id
  pg_version            = 18
  default_database_name = "lexicon-prod"
}

module "lexicon_database_aws" {
  source           = "../modules/aws/database"
  initial_db_name  = "lexicon"
  db_identifier    = "lexicon-prod"
  postgres_version = "18"
  username         = "lexicon_user"
  password         = var.lexicon_database_password
}

module "lexicon_bastion" {
  source = "../modules/aws/bastion"
  name   = "lexicon-bastion"
  allowed_ipv4s = {
    alex_home = "81.103.172.13/32"
  }
  public_ssh_key = var.public_ssh_key
}

module "lexicon_server" {
  source         = "../modules/render"
  name           = "Lexicon"
  repository_url = var.lexicon_repository_url
  docker_image   = "${var.docker_username}/lexicon"

  secrets = {
    DATABASE_URL         = var.lexicon_database_url
    NODE_ENV             = "production"
    API_BASE_URL         = "https://${var.lexicon_domain}"
    ALLOWED_ORIGINS      = "https://${var.lexicon_domain}"
    GOOGLE_CLIENT_ID     = var.lexicon_google_client_id
    GOOGLE_CLIENT_SECRET = var.lexicon_google_client_secret
    SENTRY_DSN           = var.lexicon_back_end_sentry_dsn
  }

  custom_domains    = [var.lexicon_domain]
  health_check_path = "/api/v1"
}

module "lexicon_image" {
  source      = "../modules/docker"
  namespace   = var.docker_username
  name        = "lexicon"
  description = "Dockerhub repository for the Lexicon back-end server image."
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

module "lexicon_dns_record" {
  source  = "../modules/cloudflare/dns"
  name    = var.lexicon_domain
  type    = "CNAME"
  zone_id = var.cloudflare_lexicon_zone_id
  content = "lexicon-api-lryv.onrender.com"
}
