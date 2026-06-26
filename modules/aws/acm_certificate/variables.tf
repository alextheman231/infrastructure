variable "domain_name" {
  description = "Domain name for which the certificate should be issued."
  type        = string
}

variable "validation_method" {
  description = "Which method to use for validation. Can be either DNS or EMAIL."
  type        = string
  default     = "DNS"
}

variable "subject_alternative_names" {
  description = "Set of domains that should be SANs in the issued certificate."
  type        = list(string)
  default     = []
}
