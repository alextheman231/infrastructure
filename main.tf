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
      version = "~> 6.0"
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

module "github_organisation" {
  source                  = "./modules/github/organisation"
  billing_email           = var.billing_email
  alex_up_bot_app_id      = var.alex_up_bot_app_id
  alex_up_bot_private_key = var.alex_up_bot_private_key
  webhook_url             = var.webhook_url
}
