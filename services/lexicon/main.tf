terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
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
