variable "github_owner" {
  description = "GitHub username."
  type        = string
}

variable "alex_up_bot_app_id" {
  description = "App ID for alex-up-bot, commonly used to create pull requests in GitHub Actions. This should be used alongside alex_up_bot_private_key."
  type        = string
  sensitive   = true
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

variable "vercel_team_id_lexicon_github" {
  description = "The Vercel team ID for use in Lexicon, encrypted with respect to the Lexicon GitHub repository."
  type        = string
  sensitive   = true
}

variable "vercel_lexicon_project_id" {
  description = "The ID for the Lexicon Vercel project, encrypted with respect to the Lexicon GitHub repository."
  type        = string
  sensitive   = true
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

variable "lexicon_render_deploy_key" {
  description = "Render deploy key to use to deploy the Lexicon back-end server. This has been encrypted with respect to the Lexicon GitHub repository."
  type        = string
  sensitive   = true
}
