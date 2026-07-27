data "discord_member" "alex_the_man_231" {
  server_id = var.server_id
  user_id   = "690281795618734330"
}

resource "discord_member_roles" "alex" {
  user_id   = data.discord_member.alex_the_man_231.id
  server_id = var.server_id

  role {
    role_id = discord_role.owner.id
  }
}
