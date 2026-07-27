resource "discord_role" "owner" {
  name        = "Owner"
  server_id   = var.server_id
  color       = data.discord_color.red.dec
  hoist       = true
  mentionable = true
  permissions = data.discord_permission.owner.allow_bits
}
