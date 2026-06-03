terraform {
  cloud {
    organization = "alextheman"

    workspaces {
      name = "infrastructure"
    }
  }

  required_version = ">= 1.0.0"
}


module "services" {
  source = "./services"

  github_owner                               = var.github_owner
  tfe_token                                  = var.tfe_token
  tfe_org_token                              = var.tfe_org_token
  billing_email                              = var.billing_email
  lexicon_api_domain                         = var.lexicon_api_domain
  lexicon_database_url                       = var.lexicon_database_url
  lexicon_google_client_id                   = var.lexicon_google_client_id
  neon_organisation_id                       = var.neon_organisation_id
  docker_username                            = var.docker_username
  render_api_key                             = var.render_api_key
  alex_up_bot_app_id                         = var.alex_up_bot_app_id
  alex_up_bot_private_key                    = var.alex_up_bot_private_key
  docker_pat                                 = var.docker_pat
  alex_infrastructure_bot_app_id             = var.alex_infrastructure_bot_app_id
  alex_infrastructure_bot_installation_id    = var.alex_infrastructure_bot_installation_id
  alex_infrastructure_bot_private_key_base64 = var.alex_infrastructure_bot_private_key_base64
  render_owner_id                            = var.render_owner_id
  lexicon_database_url_encrypted             = var.lexicon_database_url_encrypted
  lexicon_repository_url                     = var.lexicon_repository_url
  vercel_team_id                             = var.vercel_team_id
  alex_email                                 = var.alex_email
  lexicon_render_key                         = var.lexicon_render_key
  lexicon_render_service_id                  = var.lexicon_render_service_id
  tf_via_pr_passphrase                       = var.tf_via_pr_passphrase
  lexicon_domain                             = var.lexicon_domain
  neon_api_key                               = var.neon_api_key
  lexicon_google_client_secret               = var.lexicon_google_client_secret
  webhook_url                                = var.webhook_url
  vercel_api_token_lexicon_github            = var.vercel_api_token_lexicon_github
  vercel_api_token                           = var.vercel_api_token
  lexicon_vercel_project_id                  = var.lexicon_vercel_project_id
  docker_pat_lexicon_encrypted               = var.docker_pat_lexicon_encrypted
  sentry_infrastructure_token                = var.sentry_infrastructure_token
  sentry_organisation_id                     = var.sentry_organisation_id
  lexicon_back_end_sentry_dsn                = var.lexicon_back_end_sentry_dsn
  lexicon_front_end_sentry_dsn               = var.lexicon_front_end_sentry_dsn
  sentry_organisation_token                  = var.sentry_organisation_token
  cloudflare_api_token                       = var.cloudflare_api_token
  cloudflare_lexicon_zone_id                 = var.cloudflare_lexicon_zone_id
  lexicon_google_key                         = var.lexicon_google_key
  lexicon_google_project_id                  = var.lexicon_google_project_id
}
