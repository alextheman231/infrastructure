resource "aws_eip" "bastion" {
  tags = {
    Name = "${var.name}-elastic-ip"
  }
  domain = "vpc"
}

resource "aws_key_pair" "bastion" {
  key_name   = var.name
  public_key = var.public_ssh_key
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t4g.small"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  key_name = aws_key_pair.bastion.key_name
  user_data = templatefile("${path.module}/templates/bastion_user_data.sh.tftpl", {
    postgres_version = var.postgres_version
    database_address = var.database_address
    port             = var.port
    database_user    = var.database_user
    database_name    = var.database_name
  })
  user_data_replace_on_change = true

  tags = {
    Name = var.name
  }
}

resource "aws_eip_association" "bastion" {
  allocation_id = aws_eip.bastion.id
  instance_id   = aws_instance.bastion.id
}
