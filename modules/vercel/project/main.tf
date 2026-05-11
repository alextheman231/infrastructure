terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = ">= 4.8"
    }
  }
}

resource "vercel_project" "default" {
  team_id          = var.vercel_team_id
  name             = var.name
  framework        = var.framework
  output_directory = var.output_directory
  build_command    = var.build_command
}

resource "vercel_project_environment_variable" "secret" {
  target     = ["production"]
  for_each   = nonsensitive(var.secrets)
  project_id = vercel_project.default.id
  key        = each.key
  value      = each.value
  sensitive  = true
}

resource "vercel_project_environment_variable" "default" {
  target     = ["production"]
  for_each   = var.variables
  project_id = vercel_project.default.id
  key        = each.key
  value      = each.value
  sensitive  = true
}
