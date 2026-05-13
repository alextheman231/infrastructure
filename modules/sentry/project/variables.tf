variable "organisation_name" {
  description = "The name of the Sentry organisation"
  type        = string
  default     = "alextheman231"
}

variable "organisation_id" {
  description = "The ID of the Sentry organisation"
  type        = string
}

variable "name" {
  description = "The name of the project."
  type        = string
}

variable "platform" {
  description = "The platform for the project."
  type        = string
  default     = "javascript"
}
