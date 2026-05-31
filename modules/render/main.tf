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

resource "render_web_service" "production" {
  name           = "${var.name}-api"
  plan           = "starter"
  region         = "frankfurt"
  environment_id = render_project.default.environments["production"].id

  runtime_source = {
    image = {
      image_url = var.docker_image
    }
  }

  env_vars = {
    for key, value in nonsensitive(var.secrets) :
    key => {
      value = value
    }
  }

  custom_domains = [for value in var.custom_domains : { name : value }]
}
