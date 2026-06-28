variable "name" {
  description = "The name of the project."
  type        = string
}

variable "platform" {
  description = "The platform for the project."
  type        = string
  default     = "javascript"
}

variable "organisation_id" {
  description = "The organisation ID."
  type        = string
}

variable "teams" {
  description = "Sentry teams."
  type        = list(string)
}
