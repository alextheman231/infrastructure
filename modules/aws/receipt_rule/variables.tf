variable "name" {
  description = "The name of the rule set."
  type        = string
}

variable "rule_set_name" {
  description = "The name of the rule set."
  type        = string
}

variable "recipients" {
  description = "A list of email addresses."
  type        = list(string)
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store the emails in."
  type        = string
}

variable "position" {
  description = "The position in the rule set."
  type        = number
}

variable "ses_account_id" {
  description = "The ID of the SES account."
  type        = string
  default     = null
}
