variable "allowed_ipv4s" {
  description = "A mapping of allowed IPs."
  type        = map(string)
}

variable "bastion_security_group_id" {
  description = "The security group ID of the Bastion to allow IPs for."
  type        = string
}
