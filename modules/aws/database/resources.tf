

resource "random_id" "final_snapshot" {
  byte_length = 8
}

resource "aws_db_subnet_group" "default" {
  name = "${var.initial_db_name}-subnet-group"

  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_identifier
  }

  lifecycle {
    create_before_destroy = true
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

  deletion_protection = var.deletion_protection

  publicly_accessible = false

  vpc_security_group_ids    = var.security_group_ids
  db_subnet_group_name      = aws_db_subnet_group.default.name
  final_snapshot_identifier = "${var.db_identifier}-final-${random_id.final_snapshot.hex}"
}
