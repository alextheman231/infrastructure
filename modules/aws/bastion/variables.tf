variable "name" {
  description = "The network name"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID."
  type        = string
}

variable "public_ssh_key" {
  description = "The public key to use to log into the Bastion"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the Bastion"
  type        = list(string)
}

variable "postgres_version" {
  description = "The Postgres version"
  type        = string
  default     = "18"
}

variable "database_address" {
  description = "The database host address."
  type        = string
}

variable "port" {
  description = "The database connection port."
  type        = string
}

variable "database_user" {
  description = "The username of the user to connect to the database with."
  type        = string
}

variable "database_name" {
  description = "The name of the database."
  type        = string
}
