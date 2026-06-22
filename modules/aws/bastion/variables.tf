variable "allowed_ipv4s" {
  description = "A mapping of allowed IPs"
  type        = map(string)
}

variable "name" {
  description = "The network name"
  type        = string
}
