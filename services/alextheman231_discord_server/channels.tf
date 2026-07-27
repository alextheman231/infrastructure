module "channels" {
  source = "./channels"

  server_id = var.server_id

  admin_category_id   = discord_category_channel.admin.id
  general_category_id = discord_category_channel.general.id
}
