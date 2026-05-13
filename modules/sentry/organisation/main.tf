terraform {
  required_providers {
    sentry = {
      source  = "jianyuan/sentry"
      version = ">=0.14.3"
    }
  }
}

resource "sentry_organization" "default" {
  name        = var.name
  slug        = var.slug
  agree_terms = true
}
