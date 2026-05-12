module "lexicon_database" {
  source                = "./modules/neon"
  name                  = "Lexicon"
  org_id                = var.neon_organisation_id
  pg_version            = 17
  default_database_name = "lexicon-prod"
}

module "lexicon_server" {
  source         = "./modules/render"
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
  }
}

module "lexicon_image" {
  source      = "./modules/docker"
  namespace   = var.docker_username
  name        = "lexicon"
  description = "Dockerhub repository for the Lexicon back-end server image."
}

module "lexicon_project" {
  source           = "./modules/vercel/project"
  vercel_team_id   = var.vercel_team_id
  name             = "lexicon-front-end"
  framework        = "vite"
  output_directory = "apps/front-end/dist"
  domain           = var.lexicon_domain
}
