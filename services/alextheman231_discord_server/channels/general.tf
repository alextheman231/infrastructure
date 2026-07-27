resource "discord_text_channel" "general_discussion" {
  name      = "discussion"
  category  = var.general_category_id
  server_id = var.server_id
}
