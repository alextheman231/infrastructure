data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
}

module "session_management_role" {
  source = "../../modules/aws/iam/roles/session_management"

  name = "lexicon"
}

module "session_management" {
  source = "../../modules/aws/ec2"
  # The SSM parameter is marked sensitive by the provider, but AMI IDs are public.
  ami                  = nonsensitive(data.aws_ssm_parameter.amazon_linux.value)
  name                 = "lexicon-session-management"
  subnet_id            = var.private_subnet_ids[0]
  security_group_ids   = [module.session_management_security_group.id]
  iam_instance_profile = module.session_management_role.profile_name
}
