variable "credentials" {
  description = "The path to, or contents of, a service account key file in JSON format"
  type        = string
  sensitive   = true
}

variable "google_client_id" {
  description = "The ID to use for the OauthClient"
  type        = string
}

variable "allowed_redirect_uris" {
  description = "The list of redirect uris that is allowed to redirect back when authorization process is completed."
  type        = list(string)
}

variable "location" {
  description = "Resource ID segment making up resource name. It identifies the resource within its parent collection as described in https://google.aip.dev/122."
  type        = string
}

variable "project_id" {
  description = "The Google project ID"
  type        = string
}

variable "display_name" {
  description = "A user-specified display name of the OAuth Client."
  type        = string
  default     = null
}

variable "description" {
  description = "A user-specified description of the OAuth Client."
  type        = string
  default     = ""
}
