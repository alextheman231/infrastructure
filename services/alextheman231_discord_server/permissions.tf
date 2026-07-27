data "discord_permission" "owner" {
  administrator = "allow"
}

data "discord_permission" "bot" {
  view_channel          = "allow"
  manage_channels       = "allow"
  manage_roles          = "allow"
  manage_webhooks       = "allow"
  manage_guild          = "allow"
  create_instant_invite = "allow"
  change_nickname       = "allow"
  manage_nicknames      = "allow"
  send_messages         = "allow"
}

data "discord_permission" "no_send_messages" {
  send_messages = "deny"
}

data "discord_permission" "send_messages" {
  send_messages = "allow"
}
