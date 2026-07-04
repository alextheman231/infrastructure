variable "db_identifier" {
  description = "The database identifier"
  type        = string
}

variable "initial_db_name" {
  description = "The initial database name"
  type        = string
}

variable "postgres_version" {
  description = "The Postgres version"
  type        = string
  default     = "18"
}

variable "username" {
  description = "The database user's username"
  type        = string
}

variable "password" {
  description = "The database user's password"
  type        = string
  sensitive   = true
}

variable "bastion_security_group_id" {
  description = "The security group ID for the associated Bastion."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the database subnet group."
  type        = string
  default     = null
}
