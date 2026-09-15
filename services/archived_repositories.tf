module "neurosongs_2_repository" {
  source             = "../modules/github/repository"
  name               = "neurosongs-2"
  description        = "New version of my music-sharing app, Neurosongs."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.neurosongs.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "alex_g_bot_2_repository" {
  source             = "../modules/github/repository"
  name               = "alex-g-bot-2"
  description        = "Discord moderation bot created in TypeScript."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.alex_g_bot.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "typescript_actions_repository" {
  source             = "../modules/github/repository"
  name               = "typescript-actions"
  description        = "Composite actions developed in TypeScript to use in GitHub Actions workflows."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.package.source_code_ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = merge(local.labels.standard, local.labels.package)
}
