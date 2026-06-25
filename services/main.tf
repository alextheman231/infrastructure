terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.76.1"
    }
    neon = {
      source  = "kislerdm/neon"
      version = ">= 0.13.0"
    }
    render = {
      source  = "render-oss/render"
      version = ">= 1.8.0"
    }
    docker = {
      source  = "docker/docker"
      version = ">=0.2.0"
    }
    sentry = {
      source  = "jianyuan/sentry"
      version = ">=0.14.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=5.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
}

provider "github" {
  owner = var.github_owner

  app_auth {
    id              = var.alex_infrastructure_bot_app_id
    installation_id = var.alex_infrastructure_bot_installation_id
    pem_file        = trimspace(base64decode(var.alex_infrastructure_bot_private_key_base64))
  }
}

provider "tfe" {
  token = var.tfe_org_token
}

provider "neon" {
  api_key = var.neon_api_key
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

provider "docker" {
  username = var.docker_username
  password = var.docker_pat
}

provider "sentry" {
  token = var.sentry_infrastructure_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region     = local.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
