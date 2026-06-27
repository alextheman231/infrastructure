module "lexicon_database" {
  source                = "../../modules/neon"
  name                  = "Lexicon"
  org_id                = var.neon_organisation_id
  pg_version            = 18
  default_database_name = "lexicon-prod"
}


module "lexicon_server" {
  source         = "../../modules/render"
  name           = "Lexicon"
  repository_url = var.lexicon_repository_url
  docker_image   = module.lexicon_image.image_name

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
