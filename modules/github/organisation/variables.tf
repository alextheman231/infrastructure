variable "name" {
  description = "The organisation name."
  type        = string
}

variable "description" {
  description = "The organisation description."
  type        = string
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
  description = "The URL of a webhook to receive notifications about my organisation."
  type        = string
  sensitive   = true
}

variable "secrets" {
  description = "Secrets to use in GitHub Actions workflows in any repository in the organisation."
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "variables" {
  description = "Non-sensitive variables to use in GitHub Actions workflows in any repository in the organisation."
  type        = map(string)
  default     = {}
}

variable "admins" {
  description = "Admins of the organisation, often having higher-level permissions."
  type        = set(string)
}

variable "members" {
  description = "Members of the organisation."
  type        = set(string)
}
