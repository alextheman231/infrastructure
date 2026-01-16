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

variable "github_token" {
  description = "GitHub token."
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "GitHub username."
  type        = string
}

variable "alex_up_bot_github_token" {
  description = "Token to provide for Actions bot, AlexUpBot"
  type        = string
  sensitive   = true
}

variable "alex_up_bot_app_id" {
  description = "App ID for alex-up-bot, commonly used to create pull requests in GitHub Actions. This is intended to replace alex_up_bot_github_token as that is a PAT and less secure than a GitHub App. This should be used alongside alex_up_bot_private_key."
  type        = string
  sensitive   = true
}

variable "alex_up_bot_private_key" {
  description = "Private key for alex-up-bot app, commonly used to create pull requests in GitHub Actions. This is intended to replace alex_up_bot_github_token as that is a PAT and less secure than a GitHub App."
  type        = string
  sensitive   = true
}

variable "billing_email" {
  description = "Email associated with the organisation"
  type        = string
  validation {
    condition     = can(regex("@", var.billing_email))
    error_message = "billing_email must be a valid email address."
  }
}

variable "webhook_url" {
  description = "The URL of a webhook to receive notifications about my organisation"
  type        = string
  sensitive   = true
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

module "github_organisation" {
  source                   = "./modules/github_organisation"
  billing_email            = var.billing_email
  alex_up_bot_github_token = var.alex_up_bot_github_token
  alex_up_bot_app_id       = var.alex_up_bot_app_id
  alex_up_bot_private_key  = var.alex_up_bot_private_key
  webhook_url              = var.webhook_url
}
