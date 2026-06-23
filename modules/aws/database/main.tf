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

resource "aws_security_group" "database" {
  name   = "${var.db_identifier}-database"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_db_instance" "default" {
  identifier = var.db_identifier

  engine                      = "postgres"
  engine_version              = var.postgres_version
  allow_major_version_upgrade = true

  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.initial_db_name
  username = var.username
  password = var.password

  backup_retention_period = 7

  deletion_protection = true

  publicly_accessible = false

  vpc_security_group_ids = [aws_security_group.database.id]
}

resource "aws_vpc_security_group_ingress_rule" "bastion_postgres" {
  security_group_id = aws_security_group.database.id

  referenced_security_group_id = var.bastion_security_group_id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.database.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

output "endpoint" {
  value = aws_db_instance.default.endpoint
}

output "security_group_id" {
  value = aws_security_group.database.id
}

output "database_url" {
  sensitive = true
  value     = "postgresql://${var.username}:${var.password}@${aws_db_instance.default.address}:5432/${var.initial_db_name}"
}
