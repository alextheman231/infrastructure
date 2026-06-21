variable "github_owner" {
  description = "GitHub username."
  type        = string
}

variable "alex_up_bot_app_id" {
  description = "App ID for alex-up-bot, commonly used to create pull requests in GitHub Actions. This should be used alongside alex_up_bot_private_key."
  type        = string
}

variable "alex_up_bot_private_key" {
  description = "Private key for alex-up-bot app, commonly used to create pull requests in GitHub Actions."
  type        = string
  sensitive   = true
}

variable "alex_infrastructure_bot_app_id" {
  description = "App ID for infrastructure bot, which helps Terraform apply the configuration."
  type        = string
}

variable "alex_infrastructure_bot_installation_id" {
  description = "The ID associated with the Infrastructure bot's installation into the organisation."
  type        = string
}

variable "alex_infrastructure_bot_private_key_base64" {
  description = "Base64 encoded version of the alex-infrastructure-bot private key."
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

variable "tf_via_pr_passphrase" {
  description = "Passphrase to use with TF_via_PR action in Infrastructure CI."
  type        = string
  sensitive   = true
}

variable "tfe_token" {
  description = "Token to use to connect with HCP Terraform, encrypted and scoped with respect to the Infrastructure repository"
  type        = string
  sensitive   = true
}

variable "tfe_org_token" {
  description = "Token to use to manage the HCP Terraform organisation"
  type        = string
  sensitive   = true
}

variable "alex_email" {
  description = "My email address"
  type        = string
}

variable "tfe_organisation_name" {
  description = "The TFE organisation name."
  type        = string
  default     = "alextheman"
}

variable "vercel_api_token" {
  description = "Token to use with Vercel."
  type        = string
  sensitive   = true
}

variable "vercel_api_token_lexicon_github" {
  description = "Token to use with Vercel, encrypted with respect to the Lexicon GitHub repository."
  type        = string
  sensitive   = true
}

variable "vercel_team_id" {
  description = "ID for my Vercel team."
  type        = string
}

variable "lexicon_vercel_project_id" {
  description = "The ID for the Lexicon Vercel project."
  type        = string
}

variable "neon_api_key" {
  description = "API key to use with Neon"
  type        = string
  sensitive   = true
}

variable "neon_organisation_id" {
  description = "The ID of the Neon organisation."
  type        = string
}

variable "render_api_key" {
  description = "API key to use with Render to deploy the Lexicon server."
  type        = string
  sensitive   = true
}

variable "render_owner_id" {
  description = "My Render user ID"
  type        = string
}

variable "lexicon_repository_url" {
  description = "The link to the Lexicon GitHub repository"
  type        = string
}

variable "lexicon_render_key" {
  description = "Render API key to use to deploy the Lexicon back-end server. This has been encrypted with respect to the Lexicon GitHub repository."
  type        = string
  sensitive   = true
}

variable "lexicon_render_service_id" {
  description = "Render service ID for Lexicon back-end server"
  type        = string
}

variable "lexicon_database_url_encrypted" {
  description = "The Lexicon database URL, encrypted with respect to the Lexicon repository."
  type        = string
  sensitive   = true
}

variable "lexicon_database_url" {
  description = "The Lexicon database URL in plaintext."
  type        = string
  sensitive   = true
}

variable "lexicon_api_domain" {
  description = "Domain for Lexicon API"
  type        = string
}

variable "lexicon_domain" {
  description = "The domain name for Lexicon"
  type        = string
}

variable "lexicon_google_client_id" {
  description = "The Google Client ID for the Lexicon project."
  type        = string
}

variable "lexicon_google_client_secret" {
  description = "The Google Client Secret for the Lexicon project."
  type        = string
  sensitive   = true
}

variable "docker_username" {
  description = "My Docker username"
  type        = string
}

variable "docker_pat" {
  description = "PAT to use with DockerHub."
  type        = string
  sensitive   = true
}

variable "docker_pat_lexicon_encrypted" {
  description = "Docker PAT to use with DockerHub, encrypted with respect to Lexicon GitHub repository for use in GitHub Actions."
  type        = string
  sensitive   = true
}

variable "sentry_infrastructure_token" {
  description = "Token for Terraform to use for Sentry."
  type        = string
  sensitive   = true
}

variable "sentry_organisation_id" {
  description = "ID of the Sentry organisation"
  type        = string
}

variable "lexicon_front_end_sentry_dsn" {
  description = "The Sentry DSN for the Lexicon front-end."
  type        = string
}

variable "lexicon_back_end_sentry_dsn" {
  description = "The Sentry DSN for the Lexicon back-end."
  type        = string
}

variable "sentry_organisation_token" {
  description = "Sentry organisation token to use in GitHub Actions. This has been encrypted with respect to the alextheman231 GitHub organisation."
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Token to interact with Cloudflare"
  type        = string
  sensitive   = true
}

variable "cloudflare_lexicon_zone_id" {
  description = "The Cloudflare Lexicon Zone ID"
  type        = string
}

variable "lexicon_google_key" {
  description = "Key for the Lexicon Google project"
  type        = string
  sensitive   = true
}

variable "lexicon_google_project_id" {
  description = "The Google Project ID for Lexicon"
  type        = string
}
