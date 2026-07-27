resource "discord_role" "owner" {
  name        = "Owner"
  server_id   = var.server_id
  color       = data.discord_color.red.dec
  hoist       = true
  mentionable = true
  permissions = data.discord_permission.owner.allow_bits
}

resource "discord_role" "bot" {
  name        = "Bot"
  server_id   = var.server_id
  color       = data.discord_color.blue.dec
  hoist       = true
  mentionable = true
  permissions = data.discord_permission.bot.allow_bits
}

resource "discord_role_everyone" "default" {
  server_id   = var.server_id
  permissions = data.discord_permission.everyone.allow_bits
}
