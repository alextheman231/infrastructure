module "neurosongs_2_repository" {
  source             = "../modules/github/repository"
  name               = "neurosongs-2"
  description        = "New version of my music-sharing app, Neurosongs."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.neurosongs.ci])
}

module "alex_g_bot_2_repository" {
  source             = "../modules/github/repository"
  name               = "alex-g-bot-2"
  description        = "Discord moderation bot created in TypeScript."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.alex_g_bot.ci])
}
