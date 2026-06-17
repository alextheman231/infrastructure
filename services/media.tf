module "media_repository" {
  source             = "../modules/github/repository"
  name               = "media"
  description        = "Media used in my projects, often created with Manim."
  visibility         = "public"
  required_ci_checks = concat(local.check_list.base, [local.check_name.media.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = local.labels.standard
}
