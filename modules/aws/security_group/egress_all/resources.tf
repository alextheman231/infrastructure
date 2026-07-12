resource "aws_vpc_security_group_egress_rule" "default" {
  for_each = var.security_group_id_map

  security_group_id = each.value

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
