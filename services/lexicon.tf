moved {
  from = data.aws_iam_policy_document.lexicon_deploy
  to   = module.lexicon.data.aws_iam_policy_document.lexicon_deploy
}

moved {
  from = module.lexicon_acm_certificate
  to   = module.lexicon.module.lexicon_acm_certificate
}

moved {
  from = module.lexicon_acm_certificate_validation
  to   = module.lexicon.module.lexicon_acm_certificate_validation
}

moved {
  from = module.lexicon_bastion
  to   = module.lexicon.module.lexicon_bastion
}

moved {
  from = module.lexicon_database
  to   = module.lexicon.module.lexicon_database
}

moved {
  from = module.lexicon_database_aws
  to   = module.lexicon.module.lexicon_database_aws
}

moved {
  from = module.lexicon_deployment_role
  to   = module.lexicon.module.lexicon_deployment_role
}

moved {
  from = module.lexicon_dns_record
  to   = module.lexicon.module.lexicon_dns_record
}

moved {
  from = module.lexicon_dns_record_www
  to   = module.lexicon.module.lexicon_dns_record_www
}

moved {
  from = module.lexicon_dns_validation_records
  to   = module.lexicon.module.lexicon_dns_validation_records
}

moved {
  from = module.lexicon_ecs_service
  to   = module.lexicon.module.lexicon_ecs_service
}

moved {
  from = module.lexicon_image
  to   = module.lexicon.module.lexicon_image
}

moved {
  from = module.lexicon_load_balancer
  to   = module.lexicon.module.lexicon_load_balancer
}

moved {
  from = module.lexicon_repository
  to   = module.lexicon.module.lexicon_repository
}

moved {
  from = module.lexicon_sentry_back_end
  to   = module.lexicon.module.lexicon_sentry_back_end
}

moved {
  from = module.lexicon_sentry_front_end
  to   = module.lexicon.module.lexicon_sentry_front_end
}

moved {
  from = module.lexicon_server
  to   = module.lexicon.module.lexicon_server
}

moved {
  from = aws_vpc_security_group_ingress_rule.ecs
  to   = module.lexicon.aws_vpc_security_group_ingress_rule.ecs
}

moved {
  from = aws_vpc_security_group_ingress_rule.alb
  to   = module.lexicon.aws_vpc_security_group_ingress_rule.alb
}

module "lexicon" {
  source                    = "./lexicon"
  lexicon_database_password = var.lexicon_database_password
  docker_username           = var.docker_username
  required_ci_checks = concat(local.check_list.base, [
    local.check_name.lexicon.lint_ci,
    local.check_name.lexicon.test_ci,
    local.check_name.lexicon.end_to_end_ci
  ])
  github_labels                     = merge(local.labels.standard, local.labels.app)
  alex_up_bot_app_id                = var.alex_up_bot_app_id
  lexicon_render_key                = var.lexicon_render_key
  lexicon_database_url_encrypted    = var.lexicon_database_url_encrypted
  docker_pat_lexicon_encrypted      = var.docker_pat_lexicon_encrypted
  deployment_role_oidc_provider_arn = aws_iam_openid_connect_provider.github.arn
  neon_organisation_id              = var.neon_organisation_id
  lexicon_domain                    = var.lexicon_domain
  lexicon_google_client_id          = var.lexicon_google_client_id
  lexicon_google_client_secret      = var.lexicon_google_client_secret
  lexicon_back_end_sentry_dsn       = var.lexicon_back_end_sentry_dsn
  public_ssh_key                    = var.public_ssh_key
  lexicon_repository_url            = var.lexicon_repository_url
  lexicon_database_url              = var.lexicon_database_url
  aws_region                        = local.aws_region
  lexicon_api_domain                = var.lexicon_api_domain
  lexicon_render_service_id         = var.lexicon_render_service_id
  lexicon_front_end_sentry_dsn      = var.lexicon_front_end_sentry_dsn
  cloudflare_lexicon_zone_id        = var.cloudflare_lexicon_zone_id
}
