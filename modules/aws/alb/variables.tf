variable "name" {
  description = "The name of the Load balancer."
  type        = string
}

variable "port" {
  description = "The port to use."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "The path to run the health check on."
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the default SSL server certificate."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs."
  type        = list(string)
}
