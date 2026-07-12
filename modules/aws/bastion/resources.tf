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

  tags = {
    Name = var.name
  }
}

resource "aws_eip_association" "bastion" {
  allocation_id = aws_eip.bastion.id
  instance_id   = aws_instance.bastion.id
}
