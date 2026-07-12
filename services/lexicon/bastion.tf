module "lexicon_bastion" {
  source             = "../../modules/aws/bastion"
  name               = "lexicon-bastion"
  public_ssh_key     = var.public_ssh_key
  subnet_id          = module.lexicon_network.public_subnet_ids[0]
  security_group_ids = [module.lexicon_bastion_security_group.id]
  database_address   = module.lexicon_database.address
  database_name      = module.lexicon_database.db_name
  database_user      = module.lexicon_database.username
  port               = module.lexicon_database.port
}

module "lexicon_bastion_allowed_ips" {
  source = "../../modules/aws/security_group/allowed_ips"

  bastion_security_group_id = module.lexicon_bastion_security_group.id
  allowed_ipv4s = {
    alex_home = "81.103.172.13/32"
  }
}
