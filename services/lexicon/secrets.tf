module "lexicon_secrets" {
  source = "../../modules/aws/secrets_manager"
  name   = "lexicon"
  secrets = {
    DATABASE_URL         = module.lexicon_database_aws.database_url
    GOOGLE_CLIENT_SECRET = var.lexicon_google_client_secret
  }
}
