resource "discord_invite" "default" {
  channel_id = module.channels.welcome_leave_channel_id
  max_age    = 0
}

resource "discord_message" "invite_link" {
  channel_id = module.channels.invite_link_channel_id
  content    = "Invite other members using this link: https://discord.com/invite/${discord_invite.default.code}"
}
