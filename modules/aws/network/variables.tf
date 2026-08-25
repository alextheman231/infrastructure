variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "name" {
  description = "The name of the resource."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones to place the subnets in."
  type        = list(string)
}
