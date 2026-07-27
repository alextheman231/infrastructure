resource "discord_text_channel" "welcome_leave" {
  name      = "welcome-leave"
  category  = var.admin_category_id
  server_id = var.server_id
  position  = 0
}
