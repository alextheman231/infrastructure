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
