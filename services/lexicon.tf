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
  docker_pat_lexicon_encrypted      = var.docker_pat_lexicon_encrypted
  deployment_role_oidc_provider_arn = aws_iam_openid_connect_provider.github.arn
  lexicon_domain                    = var.lexicon_domain
  lexicon_google_client_id          = var.lexicon_google_client_id
  lexicon_google_client_secret      = var.lexicon_google_client_secret
  lexicon_back_end_sentry_dsn       = var.lexicon_back_end_sentry_dsn
  public_ssh_key                    = var.public_ssh_key
  aws_region                        = local.aws_region
  lexicon_front_end_sentry_dsn      = var.lexicon_front_end_sentry_dsn
  cloudflare_lexicon_zone_id        = var.cloudflare_lexicon_zone_id
}
