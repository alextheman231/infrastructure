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

module "github_organisation" {
  source                  = "./modules/github/organisation"
  billing_email           = var.billing_email
  alex_up_bot_app_id      = var.alex_up_bot_app_id
  alex_up_bot_private_key = var.alex_up_bot_private_key
  webhook_url             = var.webhook_url
}

