variable "allowed_ipv4s" {
  description = "A mapping of allowed IPs"
  type        = map(string)
}

variable "name" {
  description = "The network name"
  type        = string
}

variable "public_ssh_key" {
  description = "The public key to use to log into the Bastion"
  type        = string
}
