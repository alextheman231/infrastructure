module "lexicon_secrets" {
  source = "../../modules/aws/secrets_manager"
  name   = "lexicon"
  secrets = {
    GOOGLE_CLIENT_SECRET = var.lexicon_google_client_secret
  }
}
