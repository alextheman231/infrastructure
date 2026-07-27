resource "discord_text_channel" "welcome_leave" {
  name      = "welcome-leave"
  category  = var.admin_category_id
  server_id = var.server_id
}

resource "discord_text_channel" "invite_link" {
  name      = "invite-link"
  category  = var.admin_category_id
  server_id = var.server_id
}
