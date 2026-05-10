variable "name" {
  description = "The name of the Neon project."
  type        = string
}

variable "pg_version" {
  description = "The version of Postgres to use."
  type        = number
}

variable "org_id" {
  description = "Neon organisation ID."
  type        = string
}

variable "default_branch_name" {
  description = "The name of the default branch."
  type        = string
  default     = "main"
}

variable "default_database_name" {
  description = "The name of the default database."
  type        = string
}

