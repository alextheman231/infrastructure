module "github_organisation" {
  source      = "../modules/github/organisation"
  name        = "alextheman231"
  description = "This GitHub organisation is home to all my personal projects, including my programming projects, music projects, and the infrastructure for them."
  admins      = ["AlexMan123456"]
  members     = ["badstagram", "RLCreates", "peatsham"]


  billing_email = var.alex_email
  webhook_url   = var.webhook_url

  variables = {
    ALEX_UP_BOT_APP_ID = var.alex_up_bot_app_id
  }
  secrets_encrypted = {
    ALEX_UP_BOT_PRIVATE_KEY   = var.alex_up_bot_private_key
    SENTRY_ORGANISATION_TOKEN = var.sentry_organisation_token
  }
}
