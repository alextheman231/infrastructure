variable "name" {
  description = "The name of the workspace."
  type        = string
}

variable "description" {
  description = "A description of the workspace."
  type        = string
  default     = ""
}

variable "organisation_name" {
  description = "The TFE organisation name."
  type        = string
}

variable "terraform_version" {
  description = "The Terraform version"
  type        = string
  default     = "latest"
}
