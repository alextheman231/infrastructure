resource "discord_invite" "default" {
  channel_id = module.channels.welcome_leave_channel_id
  max_age    = 0
}
