module "media_repository" {
  source             = "../modules/github/repository"
  name               = "media"
  description        = "Media used in my projects, often created with Manim."
  visibility         = "public"
  required_ci_checks = concat(local.check_list.base, [local.check_name.media.ci])
  labels             = local.labels.standard
}
