data "discord_member" "alex_the_man_231" {
  server_id = var.server_id
  user_id   = "690281795618734330"
}

data "discord_member" "alex_infrastructure_bot" {
  server_id = var.server_id
  user_id   = "1531066057593196675"
}

resource "discord_member_roles" "alex" {
  user_id   = data.discord_member.alex_the_man_231.id
  server_id = var.server_id

  role {
    role_id = discord_role.owner.id
  }
}

resource "discord_member_roles" "alex_infrastructure_bot" {
  user_id   = data.discord_member.alex_infrastructure_bot.id
  server_id = var.server_id

  role {
    role_id = discord_role.bot.id
  }
}
