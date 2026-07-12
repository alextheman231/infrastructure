variable "lexicon_database_password" {
  description = "The password for the Lexicon database."
  type        = string
  sensitive   = true
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

variable "deployment_role_oidc_provider_arn" {
  description = "The OIDC provider ARN for the deployment role."
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

variable "public_ssh_key" {
  description = "My public SSH key"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to use"
  type        = string
}

variable "cloudflare_lexicon_zone_id" {
  description = "The Cloudflare Lexicon Zone ID"
  type        = string
}

variable "sentry_organisation_id" {
  description = "The Sentry organisation ID."
  type        = string
}

variable "sentry_github_integration_id" {
  description = "The ID for the integration between the Sentry organisation and GitHub."
  type        = string
}
