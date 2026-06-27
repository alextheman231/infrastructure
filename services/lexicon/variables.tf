variable "lexicon_database_password" {
  description = "The password for the Lexicon database."
  type        = string
  sensitive   = true
}

variable "docker_username" {
  description = "My Docker username"
  type        = string
}

variable "required_ci_checks" {
  description = "The checks required on the Lexicon repository for CI to pass."
  type        = list(string)
}

variable "github_labels" {
  description = "The labels for the GitHub repository"
  type = map(object({
    color       = string
    description = string
  }))
  default = {}
}

variable "alex_up_bot_app_id" {
  description = "App ID for alex-up-bot."
  type        = string
}

variable "lexicon_render_key" {
  description = "Render API key to use to deploy the Lexicon back-end server. This has been encrypted with respect to the Lexicon GitHub repository."
  type        = string
  sensitive   = true
}

variable "lexicon_database_url_encrypted" {
  description = "The Lexicon database URL, encrypted with respect to the Lexicon repository."
  type        = string
  sensitive   = true
}

variable "docker_pat_lexicon_encrypted" {
  description = "Docker PAT to use with DockerHub, encrypted with respect to Lexicon GitHub repository for use in GitHub Actions."
  type        = string
  sensitive   = true
}

variable "deployment_role_oidc_provider_arn" {
  description = "The OIDC provider ARN for the deployment role."
  type        = string
}

variable "neon_organisation_id" {
  description = "The ID of the Neon organisation."
  type        = string
}

variable "lexicon_repository_url" {
  description = "The link to the Lexicon GitHub repository"
  type        = string
}

variable "lexicon_database_url" {
  description = "The Lexicon database URL in plaintext."
  type        = string
  sensitive   = true
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

variable "lexicon_back_end_sentry_dsn" {
  description = "The Sentry DSN for the Lexicon back-end."
  type        = string
}

variable "public_ssh_key" {
  description = "My public SSH key"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to use"
  type        = string
}

variable "lexicon_api_domain" {
  description = "Domain for Lexicon API"
  type        = string
}

variable "lexicon_render_service_id" {
  description = "Render service ID for Lexicon back-end server"
  type        = string
}

variable "lexicon_front_end_sentry_dsn" {
  description = "The Sentry DSN for the Lexicon front-end."
  type        = string
}

variable "cloudflare_lexicon_zone_id" {
  description = "The Cloudflare Lexicon Zone ID"
  type        = string
}
