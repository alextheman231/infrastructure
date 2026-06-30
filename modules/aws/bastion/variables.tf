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

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID."
  type        = string
}
