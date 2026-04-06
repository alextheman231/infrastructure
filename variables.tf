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
