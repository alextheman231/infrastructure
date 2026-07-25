variable "name" {
  description = "Name of the bucket."
  type        = string
}

variable "auto_delete_after_days" {
  description = "The lifetime of the bucket's objects."
  type        = number
  default     = 0
}
