variable "name" {
  description = "The name of the Render project."
  type        = string
}

variable "repository_url" {
  description = "The link to the repository to deploy from."
  type        = string
}

variable "secrets" {
  description = "A map of secrets for the given Render project."
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "docker_image" {
  description = "The URL to the Docker image to deploy."
  type        = string
}

variable "custom_domains" {
  description = "Custom domains to associate with the service"
  type        = list(string)
}

variable "health_check_path" {
  description = "The path where the server will always return a 200 response. Used to monitor the app and for zero downtime deploys."
  type        = string
  default     = "/api"
}
