data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-20*-kernel-*-arm64"]
  }
}

module "session_management_role" {
  source = "../../modules/aws/iam/roles/session_management"

  name = "lexicon"
}

module "session_management" {
  source               = "../../modules/aws/ec2"
  ami                  = data.aws_ami.amazon_linux.id
  name                 = "lexicon-session-management"
  subnet_id            = var.private_subnet_ids[0]
  security_group_ids   = [module.session_management_security_group.id]
  iam_instance_profile = module.session_management_role.profile_name
}
