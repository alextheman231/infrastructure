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
