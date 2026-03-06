locals {
  check_name = {
    actions_ci                    = "actions-ci / actions-ci",
    restrict_alex_up_bot_branches = "restrict-alex-up-bot-branches / restrict-alex-up-bot-branches",

    package = {
      source_code_ci    = "package-ci / source-code-ci",
      version_change_ci = "package-ci / version-change-ci / version-change-ci"
    }

    end_to_end_ci = "end-to-end-ci"

    terraform = {
      lint_ci = "terraform-lint-ci"
      plan_ci = "terraform-plan-ci"
    }

    github_actions = {
      actions_ci        = "actions-ci"
      version_change_ci = "version-change-ci / version-change-ci"
    }

    blog_site = {
      ci = "blog-site-ci"
    }

    neurosongs = {
      ci = "neurosongs-ci"
    }

    alex_g_bot = {
      ci = "alex-g-bot-ci"
    }

    media = {
      ci = "media-ci"
    }
  }

  _base_checks = [
    local.check_name.actions_ci,
    local.check_name.restrict_alex_up_bot_branches
  ]

  check_list = {
    base = local._base_checks

    package = concat(local._base_checks, [
      local.check_name.package.source_code_ci,
      local.check_name.package.version_change_ci,
      local.check_name.actions_ci,
      local.check_name.end_to_end_ci
    ])

    github_actions = {
      base = [
        for check in local._base_checks :
        check
        if check != local.check_name.actions_ci
      ]
    }
  }
}

module "infrastructure_repository" {
  source      = "./modules/repository"
  name        = "infrastructure"
  description = "Infrastructure for my GitHub repositories."
  visibility  = "public"
  required_ci_checks = concat(local.check_list.base, [
    local.check_name.terraform.lint_ci,
    local.check_name.terraform.plan_ci,
  ])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "utility_repository" {
  source             = "./modules/repository"
  name               = "utility"
  description        = "A package to provide helpful utility functions to be used in most modern JavaScript/TypeScript projects."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "eslint_plugin_repository" {
  source             = "./modules/repository"
  name               = "eslint-plugin"
  description        = "A package to provide custom ESLint rules and configs."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "components_repository" {
  source             = "./modules/repository"
  name               = "components"
  description        = "A package containing common React components used across my projects."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "alex_c_line_repository" {
  source             = "./modules/repository"
  name               = "alex-c-line"
  description        = "Command-line tool with commands to streamline the developer workflow."
  visibility         = "public"
  required_ci_checks = local.check_list.package
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "github_actions_repository" {
  source      = "./modules/repository"
  name        = "github-actions"
  description = "Common GitHub Actions used across my repositories."
  visibility  = "public"
  required_ci_checks = concat(
    local.check_list.github_actions.base,
    [local.check_name.github_actions.actions_ci, local.check_name.github_actions.version_change_ci]
  )
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "blog_site_repository" {
  source             = "./modules/repository"
  name               = "blog-site"
  description        = "The true successor to Neurosongs, allowing users to write blogs and share them, with a dynamic editor to help with in-line images/audio/files in general."
  visibility         = "public"
  required_ci_checks = concat(local.check_list.base, [local.check_name.blog_site.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "neurosongs_2_repository" {
  source             = "./modules/repository"
  name               = "neurosongs-2"
  description        = "New version of my music-sharing app, Neurosongs."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.neurosongs.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "alex_g_bot_2_repository" {
  source             = "./modules/repository"
  name               = "alex-g-bot-2"
  description        = "Discord moderation bot created in TypeScript."
  visibility         = "public"
  archived           = true
  required_ci_checks = concat(local.check_list.base, [local.check_name.alex_g_bot.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}

module "media_repository" {
  source             = "./modules/repository"
  name               = "media"
  description        = "Media used in my projects, often created with Manim."
  visibility         = "public"
  required_ci_checks = concat(local.check_list.base, [local.check_name.media.ci])
  alex_up_bot_app_id = var.alex_up_bot_app_id
}
