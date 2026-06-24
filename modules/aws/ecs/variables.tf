variable "name" {
  description = "The name of the service."
  type        = string
}

variable "cpu" {
  description = "Number of CPU units for the task."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Amount of memory used by the task in MiB."
  type        = number
  default     = 512
}

variable "image" {
  description = "The image to deploy."
  type        = string
}

variable "environment_variables" {
  description = "The environment variables for the service."
  sensitive   = true
  type        = map(string)
}

variable "fargate_version" {
  description = "The Fargate version"
  type        = string
  default     = "1.4.0"
}
