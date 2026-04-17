terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.76.1"
    }
  }
}

resource "tfe_workspace" "default" {
  name                  = var.name
  organization          = var.organisation_name
  description           = var.description
  file_triggers_enabled = false
  speculative_enabled   = true
}

resource "tfe_workspace_settings" "default" {
  workspace_id   = tfe_workspace.default.id
  execution_mode = "remote"
  auto_apply     = false
}
