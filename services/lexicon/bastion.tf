module "lexicon_bastion" {
  source = "../../modules/aws/bastion"
  name   = "lexicon-bastion"
  allowed_ipv4s = {
    alex_home = "81.103.172.13/32"
  }
  public_ssh_key = var.public_ssh_key
  vpc_id         = module.lexicon_network.vpc_id
  subnet_id      = module.lexicon_network.public_subnet_ids[0]
}
