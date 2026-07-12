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
