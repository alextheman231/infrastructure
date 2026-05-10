terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = ">= 4.8"
    }
  }
}

resource "vercel_team_config" "default" {
  id                                    = var.vercel_team_id
  name                                  = var.name
  sensitive_environment_variable_policy = "on"
  remote_caching = {
    enabled = false
  }
  enable_preview_feedback    = "on"
  enable_production_feedback = "off"
  description                = var.description
}
