module "utility_repository" {
  source             = "../modules/github/repository"
  name               = "utility"
  description        = "A package to provide helpful utility functions to be used in most modern JavaScript/TypeScript projects."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
  has_pages          = true
  labels             = local.labels.standard
}

module "eslint_plugin_repository" {
  source             = "../modules/github/repository"
  name               = "eslint-plugin"
  description        = "A package to provide custom ESLint rules and configs."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = local.labels.standard
}

module "components_repository" {
  source      = "../modules/github/repository"
  name        = "components"
  description = "A package containing common React components used across my projects."
  visibility  = "public"
  required_ci_checks = concat([
    for check in local.check_list.package :
    check
    if check != local.check_name.end_to_end_ci
  ], [local.check_name.components.end_to_end_ci])
  has_pages          = true
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = merge(local.labels.standard, local.labels.package)
}

module "alex_c_line_repository" {
  source             = "../modules/github/repository"
  name               = "alex-c-line"
  description        = "Command-line tool with commands to streamline the developer workflow."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = merge(local.labels.standard, local.labels.package)
}

module "github_actions_repository" {
  source      = "../modules/github/repository"
  name        = "github-actions"
  description = "Common GitHub Actions used across my repositories."
  visibility  = "public"
  required_ci_checks = concat(
    local.check_list.github_actions.base,
    [local.check_name.github_actions.actions_ci, local.check_name.github_actions.version_change_ci]
  )
  has_pages          = true
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = merge(local.labels.standard, local.labels.package)
}

module "typescript_actions_repository" {
  source             = "../modules/github/repository"
  name               = "typescript-actions"
  description        = "Composite actions developed in TypeScript to use in GitHub Actions workflows."
  visibility         = "public"
  required_ci_checks = concat(local.check_list.base, [local.check_name.package.source_code_ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
  labels             = merge(local.labels.standard, local.labels.package)
}
