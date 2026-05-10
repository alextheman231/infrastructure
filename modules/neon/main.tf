terraform {
  required_providers {
    neon = {
      source  = "kislerdm/neon"
      version = ">= 0.13.0"
    }
  }
}

resource "neon_project" "default" {
  name       = var.name
  org_id     = var.org_id
  pg_version = var.pg_version
}

