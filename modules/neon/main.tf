terraform {
  required_providers {
    neon = {
      source  = "kislerdm/neon"
      version = ">= 0.13.0"
    }
  }
}

resource "neon_project" "default" {
  name                      = var.name
  org_id                    = var.org_id
  pg_version                = var.pg_version
  history_retention_seconds = 21600

  branch {
    name          = var.default_branch_name
    database_name = var.default_database_name
  }
}

