terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.8.0"
    }
  }
}

resource "render_project" "default" {
  name = var.name
  environments = {
    "deploy_preview" = {
      name             = "deploy_preview"
      protected_status = "unprotected"
    }
    "production" = {
      name             = "production"
      protected_status = "protected"
    }
  }
}
