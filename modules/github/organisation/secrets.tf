resource "github_actions_organization_secret" "alex_up_bot_app_id" {
  secret_name = "ALEX_UP_BOT_APP_ID"
  value       = var.alex_up_bot_app_id
  visibility  = "all"
}

resource "github_actions_organization_secret" "alex_up_bot_private_key" {
  secret_name     = "ALEX_UP_BOT_PRIVATE_KEY"
  value_encrypted = var.alex_up_bot_private_key
  visibility      = "all"
}
