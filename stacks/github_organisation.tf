module "github_organisation" {
  source                  = "../modules/github/organisation"
  billing_email           = var.billing_email
  alex_up_bot_app_id      = var.alex_up_bot_app_id
  alex_up_bot_private_key = var.alex_up_bot_private_key
  webhook_url             = var.webhook_url
}
