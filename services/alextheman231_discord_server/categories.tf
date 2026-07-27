resource "discord_category_channel" "admin" {
  name      = "Admin"
  server_id = var.server_id
  position  = 0
}

resource "discord_category_channel" "general" {
  name      = "General"
  server_id = var.server_id
  position  = 1
}
