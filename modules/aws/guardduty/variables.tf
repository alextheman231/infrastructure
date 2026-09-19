variable "malware_protection_role_name" {
  description = "The name of the GuardDuty malware protection role."
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket to protect."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to protect."
  type        = string
}

variable "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector."
  type        = string
}
