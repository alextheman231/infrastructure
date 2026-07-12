resource "aws_security_group" "default" {
  name   = var.name
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}
