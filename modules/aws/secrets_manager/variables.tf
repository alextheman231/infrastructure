variable "name" {
  description = "The secret manager name."
  type        = string
}

variable "secrets" {
  description = "The secrets to use."
  type        = map(string)
  sensitive   = true
}
