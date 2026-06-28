module "github_organisation" {
  source      = "../modules/github/organisation"
  name        = "alextheman231"
  description = "This GitHub organisation is home to all my mainline NPM packages, shared GitHub Actions, Infrastructure, and applications."
  admins      = ["AlexMan123456"]
  members     = ["badstagram", "RLCreates", "peatsham"]


  billing_email = var.alex_email
  webhook_url   = var.webhook_url

  variables = {
    ALEX_UP_BOT_APP_ID = var.alex_up_bot_app_id
  }
  secrets = {
    ALEX_UP_BOT_PRIVATE_KEY   = var.alex_up_bot_private_key
    SENTRY_ORGANISATION_TOKEN = var.sentry_organisation_token
  }
}
