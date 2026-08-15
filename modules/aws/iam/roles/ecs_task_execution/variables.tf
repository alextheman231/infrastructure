variable "name" {
  description = "The name of the role."
  type        = string
}

variable "secret_arns" {
  description = "Mapping of secret environment variable names to AWS Secrets Manager ARNs."
  type        = map(string)
}
