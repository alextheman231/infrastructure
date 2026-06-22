terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
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
}
