variable "security_group_id_map" {
  description = "A map of security group IDs to apply the egress rule to."
  type        = map(string)
}
