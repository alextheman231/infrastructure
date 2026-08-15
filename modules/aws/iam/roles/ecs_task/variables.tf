variable "name" {
  description = "The name of the role."
  type        = string
}

variable "s3_bucket_arns" {
  description = "List of the ARNs of S3 buckets to allow access to."
  type        = list(string)
  default     = []
}
