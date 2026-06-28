variable "name" {
  description = "The ECR repository name."
  type        = string
}

variable "expire_untagged_images_after_days" {
  description = "The amount of days to wait to expire untagged images."
  type        = number
  default     = 7
}
