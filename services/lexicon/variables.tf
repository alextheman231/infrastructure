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

variable "docker_pat_lexicon_encrypted" {
  description = "Docker PAT to use with DockerHub, encrypted with respect to Lexicon GitHub repository for use in GitHub Actions."
  type        = string
  sensitive   = true
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

variable "lexicon_front_end_sentry_dsn" {
  description = "The Sentry DSN for the Lexicon front-end."
  type        = string
}

variable "cloudflare_lexicon_zone_id" {
  description = "The Cloudflare Lexicon Zone ID"
  type        = string
}
