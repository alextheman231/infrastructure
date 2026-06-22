terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "bastion" {
  name   = var.name
  vpc_id = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "default" {
  for_each = var.allowed_ipv4s

  security_group_id = aws_security_group.bastion.id

  cidr_ipv4   = each.value
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  description = each.key
}

resource "aws_vpc_security_group_egress_rule" "default" {
  security_group_id = aws_security_group.bastion.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
