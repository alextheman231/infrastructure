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

variable "subnet_ids" {
  description = "The subnet IDs."
  type        = list(string)
}

variable "deletion_protection" {
  description = "Whether to protect the database from being destroyed or not."
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the database"
  type        = list(string)
}

variable "autovacuum_vacuum_scale_factor" {
  type    = number
  default = 0.02
}

variable "autovacuum_vacuum_insert_scale_factor" {
  type    = number
  default = 0.02
}

variable "work_mem" {
  description = "The work memory limit in kilobytes."
  type        = number
  default     = 8192
}

