locals {
  repositories = {
    "infrastructure" = {
      description        = "Infrastructure for my GitHub repositories."
      visibility         = "public"
      required_ci_checks = ["terraform-ci", "actions-ci / actions-ci"]
      enable_merge_queue = true
    }

    "utility" = {
      description        = "Helpful utility functions."
      visibility         = "public"
      required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
    }

    "eslint-plugin" = {
      description        = "A package to provide custom ESLint rules and configs."
      visibility         = "public"
      required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
    }

    "components" = {
      description        = "A package containing common React components used across my projects."
      visibility         = "public"
      required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
    }

    "alex-c-line" = {
      description        = "Command-line tool with commands to streamline the developer workflow."
      visibility         = "public"
      required_ci_checks = ["package-ci / pnpm-ci", "actions-ci / actions-ci"]
    }

    "github-actions" = {
      description        = "Common GitHub Actions used across my repositories."
      visibility         = "public"
      required_ci_checks = ["self-ci"]
    }

    "neurosongs-2" = {
      description        = "New version of my music-sharing app, Neurosongs."
      visibility         = "public"
      required_ci_checks = ["neurosongs-ci", "actions-ci / actions-ci"]
    }

    "alex-g-bot-2" = {
      description        = "Discord moderation bot created in TypeScript."
      visibility         = "public"
      required_ci_checks = ["alex-g-bot-ci", "actions-ci / actions-ci"]
    }
  }
}

module "repository" {
  for_each = local.repositories
  source   = "./modules/repository"

  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility

  has_issues   = try(each.value.has_issues, true)
  has_projects = try(each.value.has_projects, false)
  has_wiki     = try(each.value.has_wiki, false)

  archived = try(each.value.archived, false)

  required_ci_checks = try(each.value.required_ci_checks, [])
  enable_merge_queue = try(each.value.enable_merge_queue, false)
}
