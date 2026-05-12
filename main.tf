terraform {
  cloud {
    organization = "alextheman"

    workspaces {
      name = "infrastructure"
    }
  }

  required_version = ">= 1.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.76.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = ">= 4.8"
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

provider "vercel" {
  api_token = var.vercel_api_token
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
