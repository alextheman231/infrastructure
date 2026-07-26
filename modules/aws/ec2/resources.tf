resource "aws_instance" "default" {
  ami                    = var.ami
  instance_type          = "t4g.small"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  tags = {
    Name = var.name
  }
}
