locals {
  repositories = {
    "commit-to-you" = {
      description = "Source files for the Commit To You album (Logic Pro + SynthV sources)."
      visibility  = "public"
    }

    "infrastructure" = {
      description = "Infrastructure for my GitHub repositories."
      visibility  = "public"
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
}
