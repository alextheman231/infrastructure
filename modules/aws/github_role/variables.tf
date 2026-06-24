variable "repository" {
  description = "The GitHub repository, structured as owner/repo."
  type        = string
}

variable "role_name" {
  description = "The IAM role name."
  type        = string
}

variable "oidc_provider_arn" {
  description = "The OIDC provider ARN."
  type        = string
}

variable "policy_json" {
  description = "The IAM policy to attach."
  type        = string
}
