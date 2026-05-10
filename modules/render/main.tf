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
    docker = {
      auto_deploy = false
      branch      = "main"
      repo_url    = var.repository_url
    }
  }
}

resource "render_env_group" "default" {
  name           = "${var.name} secrets"
  environment_id = render_project.default.environments["production"].id
  env_vars = {
    for key, value in nonsensitive(var.secrets) :
    key => {
      value = value
    }
  }
}
