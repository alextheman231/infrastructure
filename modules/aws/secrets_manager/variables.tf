variable "name" {
  description = "The secret manager name."
  type        = string
}

variable "secrets" {
  description = "The secrets to use."
  type        = map(string)
  sensitive   = true
}

variable "plan_role_id" {
  description = "The Terraform plan role ID."
  type        = string
}

variable "allowed_role_ids" {
  description = "Role IDs to allow secret access to."
  type        = map(string)
  default     = {}
}
