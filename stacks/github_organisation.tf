module "github_organisation" {
  source  = "../modules/github/organisation"
  admins  = ["AlexMan123456"]
  members = ["badstagram", "RLCreates"]


  billing_email = var.billing_email
  webhook_url   = var.webhook_url

  variables = {
    ALEX_UP_BOT_APP_ID = var.alex_up_bot_app_id
  }
  secrets = {
    ALEX_UP_BOT_PRIVATE_KEY = var.alex_up_bot_private_key
  }
}
