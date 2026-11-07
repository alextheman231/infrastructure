module "media_repository" {
  source      = "../modules/github/repository"
  name        = "media"
  description = "Media used in my projects, often created with Manim."
  visibility  = "public"
  required_ci_checks = concat(
    [
      for check in local.check_list.base :
      check
      if check != local.check_name.pyproject_lint_ci
  ], [local.check_name.media.ci])
  admin_team_id = module.github_organisation.admin_team_id
  labels        = local.labels.standard
}
