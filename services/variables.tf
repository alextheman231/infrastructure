variable "github_owner" {
  description = "GitHub username."
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

variable "webhook_url" {
  description = "The URL of a webhook to receive notifications about my organisation"
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
  validation {
    condition     = can(regex("@", var.alex_email))
    error_message = "alex_email must be a valid email address."
  }
}

variable "tfe_organisation_name" {
  description = "The TFE organisation name."
  type        = string
  default     = "alextheman"
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

variable "sentry_infrastructure_token" {
  description = "Token for Terraform to use for Sentry."
  type        = string
  sensitive   = true
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

variable "lexicon_database_password" {
  description = "The password for the Lexicon database."
  type        = string
  sensitive   = true
}

variable "public_ssh_key" {
  description = "My public SSH key"
  type        = string
}
