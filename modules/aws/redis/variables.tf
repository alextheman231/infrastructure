variable "name" {
  description = "Name of the Redis Elasticache cluster."
  type        = string
}

variable "node_type" {
  description = "The instance class used."
  type        = string
  default     = "cache.t3.micro"
}

variable "port" {
  description = "The port to use."
  type        = number
  default     = 6379
}

variable "security_group_ids" {
  description = "The security group IDs associated with the Redis Elasticache cluster."
  type        = list(string)
}

variable "subnet_group_name" {
  description = "The subnet group name."
  type        = string
}
