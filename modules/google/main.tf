terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=7.35.0"
    }
  }
}

provider "google" {
  credentials = var.credentials
  project     = var.project_id
}

resource "google_iam_oauth_client" "default" {
  allowed_scopes        = ["openid"]
  allowed_grant_types   = ["AUTHORIZATION_CODE_GRANT"]
  allowed_redirect_uris = var.allowed_redirect_uris
  oauth_client_id       = var.google_client_id
  location              = var.location
  display_name          = var.display_name
  description           = var.description
  client_type           = var.client_type
}
