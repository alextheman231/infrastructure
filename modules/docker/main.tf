terraform {
  required_providers {
    docker = {
      source  = "docker/docker"
      version = ">=0.2.0"
    }
  }
}

resource "docker_hub_repository" "default" {
  namespace   = var.namespace
  name        = var.name
  description = var.description
}
