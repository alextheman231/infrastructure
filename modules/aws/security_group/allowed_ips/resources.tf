resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  for_each = var.allowed_ipv4s

  security_group_id = var.bastion_security_group_id

  cidr_ipv4   = each.value
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  description = each.key
}
