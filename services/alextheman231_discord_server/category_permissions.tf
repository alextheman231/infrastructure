resource "discord_channel_permission" "admin_category_everyone" {
  channel_id   = discord_category_channel.admin.id
  allow        = data.discord_permission.no_send_messages.allow_bits
  type         = "role"
  overwrite_id = discord_role_everyone.default.id
}

resource "discord_channel_permission" "admin_category_bot" {
  channel_id   = discord_category_channel.admin.id
  allow        = data.discord_permission.send_messages.allow_bits
  type         = "role"
  overwrite_id = discord_role.bot.id
}
