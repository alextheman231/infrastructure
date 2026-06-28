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
  alex_up_bot_app_id                         = var.alex_up_bot_app_id
  alex_up_bot_private_key                    = var.alex_up_bot_private_key
  docker_pat                                 = var.docker_pat
  alex_infrastructure_bot_app_id             = var.alex_infrastructure_bot_app_id
  alex_infrastructure_bot_installation_id    = var.alex_infrastructure_bot_installation_id
  alex_infrastructure_bot_private_key_base64 = var.alex_infrastructure_bot_private_key_base64
  alex_email                                 = var.alex_email
  lexicon_domain                             = var.lexicon_domain
  lexicon_google_client_secret               = var.lexicon_google_client_secret
  webhook_url                                = var.webhook_url
  docker_pat_lexicon_encrypted               = var.docker_pat_lexicon_encrypted
  sentry_infrastructure_token                = var.sentry_infrastructure_token
  sentry_organisation_token                  = var.sentry_organisation_token
  cloudflare_api_token                       = var.cloudflare_api_token
  cloudflare_lexicon_zone_id                 = var.cloudflare_lexicon_zone_id
  lexicon_database_password                  = var.lexicon_database_password
  public_ssh_key                             = var.public_ssh_key
}
