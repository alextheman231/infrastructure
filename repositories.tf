module "infrastructure_repository" {
  source             = "./modules/repository"
  name               = "infrastructure"
  description        = "Infrastructure for my GitHub repositories."
  visibility         = "public"
  required_ci_checks = ["terraform-ci", "actions-ci / actions-ci", "Terraform Cloud/alextheman/repo-id-ZkeqqaSSmNywdbav"]
  enable_merge_queue = false
}

module "utility_repository" {
  source             = "./modules/repository"
  name               = "utility"
  description        = "Helpful utility functions."
  visibility         = "public"
  required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
}

module "eslint_plugin_repository" {
  source             = "./modules/repository"
  name               = "eslint-plugin"
  description        = "A package to provide custom ESLint rules and configs."
  visibility         = "public"
  required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
}

module "components_repository" {
  source             = "./modules/repository"
  name               = "components"
  description        = "A package containing common React components used across my projects."
  visibility         = "public"
  required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
}

module "alex_c_line_repository" {
  source             = "./modules/repository"
  name               = "alex-c-line"
  description        = "Command-line tool with commands to streamline the developer workflow."
  visibility         = "public"
  required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
}

module "github_actions_repository" {
  source             = "./modules/repository"
  name               = "github-actions"
  description        = "Common GitHub Actions used across my repositories."
  visibility         = "public"
  required_ci_checks = ["self-ci"]
}

module "blog_site_repository" {
  source      = "./modules/repository"
  name        = "blog-site"
  description = "The true successor to Neurosongs, allowing users to write blogs and share them, with a dynamic editor to help with in-line images/audio/files in general."
  visibility  = "public"
}

module "neurosongs_2_repository" {
  source             = "./modules/repository"
  name               = "neurosongs-2"
  description        = "New version of my music-sharing app, Neurosongs."
  visibility         = "public"
  required_ci_checks = ["neurosongs-ci", "actions-ci / actions-ci"]
}

module "alex_g_bot_2_repository" {
  source             = "./modules/repository"
  name               = "alex-g-bot-2"
  description        = "Discord moderation bot created in TypeScript."
  visibility         = "public"
  required_ci_checks = ["alex-g-bot-ci", "actions-ci / actions-ci"]
}
