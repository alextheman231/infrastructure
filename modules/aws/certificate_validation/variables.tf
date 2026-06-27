variable "validation_record_fqdns" {
  description = "List of FQDNs that implement the validation."
  type        = list(string)
}

variable "certificate_arn" {
  description = "The ARN of the certificate to validate."
  type        = string
}
