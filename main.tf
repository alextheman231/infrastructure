terraform {
  cloud {
    organization = "alextheman"

    workspaces {
      name = "infrastructure"
    }
  }

  required_version = "~> 1.15"
}


module "services" {
  source = "./services"

  github_owner                               = var.github_owner
  tfe_token                                  = var.tfe_token
  tfe_org_token                              = var.tfe_org_token
  billing_email                              = var.billing_email
  lexicon_google_client_id                   = var.lexicon_google_client_id
  docker_username                            = var.docker_username
  render_api_key                             = var.render_api_key
  alex_up_bot_app_id                         = var.alex_up_bot_app_id
  alex_up_bot_private_key                    = var.alex_up_bot_private_key
  docker_pat                                 = var.docker_pat
  alex_infrastructure_bot_app_id             = var.alex_infrastructure_bot_app_id
  alex_infrastructure_bot_installation_id    = var.alex_infrastructure_bot_installation_id
  alex_infrastructure_bot_private_key_base64 = var.alex_infrastructure_bot_private_key_base64
  render_owner_id                            = var.render_owner_id
  alex_email                                 = var.alex_email
  lexicon_domain                             = var.lexicon_domain
  lexicon_google_client_secret               = var.lexicon_google_client_secret
  webhook_url                                = var.webhook_url
  docker_pat_lexicon_encrypted               = var.docker_pat_lexicon_encrypted
  sentry_infrastructure_token                = var.sentry_infrastructure_token
  sentry_organisation_id                     = var.sentry_organisation_id
  lexicon_back_end_sentry_dsn                = var.lexicon_back_end_sentry_dsn
  lexicon_front_end_sentry_dsn               = var.lexicon_front_end_sentry_dsn
  sentry_organisation_token                  = var.sentry_organisation_token
  cloudflare_api_token                       = var.cloudflare_api_token
  cloudflare_lexicon_zone_id                 = var.cloudflare_lexicon_zone_id
  aws_access_key                             = var.aws_access_key
  aws_secret_key                             = var.aws_secret_key
  aws_instance_arn                           = var.aws_instance_arn
  lexicon_database_password                  = var.lexicon_database_password
  public_ssh_key                             = var.public_ssh_key
  neon_api_key                               = var.neon_api_key
}
