terraform {
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

provider "github" {
  token = var.github_token
  owner = var.github_owner
}
