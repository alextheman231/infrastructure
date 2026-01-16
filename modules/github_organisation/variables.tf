variable "billing_email" {
  description = "Email associated with the organisation"
  type        = string
  validation {
    condition     = can(regex("@", var.billing_email))
    error_message = "billing_email must be a valid email address."
  }
}

variable "alex_up_bot_github_token" {
  description = "Token to provide for Actions bot, AlexUpBot"
  type        = string
  sensitive   = true
}

variable "alex_up_bot_private_key" {
  description = "Private key for alex-up-bot app, commonly used to create pull requests in GitHub Actions. This is intended to replace alex_up_bot_github_token as that is a PAT and less secure than a GitHub App."
  type        = string
  sensitive   = true
}

variable "alex_up_bot_app_id" {
  description = "App ID for alex-up-bot, commonly used to create pull requests in GitHub Actions. This is intended to replace alex_up_bot_github_token as that is a PAT and less secure than a GitHub App. This should be used alongside alex_up_bot_private_key."
  type        = string
  sensitive   = true
}

variable "webhook_url" {
  description = "The URL of a webhook to receive notifications about my organisation."
  type        = string
  sensitive   = true
}
