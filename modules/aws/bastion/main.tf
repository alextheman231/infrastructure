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

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*-arm64"]
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
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

resource "aws_key_pair" "bastion" {
  key_name   = var.name
  public_key = var.public_ssh_key
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t4g.nano"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.bastion.id]

  key_name = aws_key_pair.bastion.key_name

  tags = {
    Name = var.name
  }
}

output "security_group_id" {
  value = aws_security_group.bastion.id
}

output "public_ip" {
  value = aws_instance.bastion.public_ip
}
