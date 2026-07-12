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

variable "github_integration_id" {
  description = "The ID for the integration between the organisation and GitHub."
  type        = string
}

variable "sentry_repository_id" {
  description = "The ID of the Sentry repository."
  type        = string
}

variable "source_root" {
  description = "The root of the source code."
  type        = string
  default     = "src"
}
