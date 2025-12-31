locals {
  repositories = {
    "commit-to-you" = {
      description = "Source files for the Commit To You album (Logic Pro + SynthV sources)."
      visibility  = "public"
    }

    "infrastructure" = {
      description        = "Infrastructure for my GitHub repositories."
      visibility         = "public"
      required_ci_checks = ["terraform-ci", "Terraform Cloud/alextheman/repo-id-pmMPm4vxcUqSJvzV"]
    }

    "utility" = {
      description        = "Helpful utility functions."
      visibility         = "public"
      required_ci_checks = ["ci / pnpm-ci"]
    }

    "eslint-plugin" = {
      description        = "A package to provide custom ESLint rules and configs."
      visibility         = "public"
      required_ci_checks = ["ci / pnpm-ci"]
    }

    "components" = {
      description        = "A package containing common React components used across my projects."
      visibility         = "public"
      required_ci_checks = ["ci / pnpm-ci"]
    }

    "alex-c-line" = {
      description        = "Command-line tool with commands to streamline the developer workflow."
      visibility         = "public"
      required_ci_checks = ["ci / pnpm-ci"]
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

  enable_branch_protection = try(each.value.required_ci_checks, null) != null
  required_ci_checks       = try(each.value.required_ci_checks, null)
}
