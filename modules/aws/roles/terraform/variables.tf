variable "organization" {
  description = "The HCP Terraform organisation name."
  type        = string
}

variable "project" {
  description = "The HCP Terraform project name."
  type        = string
}

variable "workspace" {
  description = "The HCP Terraform workspace name."
  type        = string
}

variable "run_phase" {
  description = "The run phase for the role to apply to. Can be either plan or apply."
  type        = string
  validation {
    condition     = contains(["plan", "apply"], var.run_phase)
    error_message = "run_phase must be either 'plan' or 'apply'."
  }
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
  type     = string
  nullable = true
  default  = null
}
