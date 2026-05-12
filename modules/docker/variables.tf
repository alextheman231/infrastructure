variable "namespace" {
  description = "The repository namespace."
  type        = string
}

variable "name" {
  description = "The repository name."
  type        = string
}

variable "description" {
  description = "The repository description."
  type        = string
  default     = ""
}
