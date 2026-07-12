module "lexicon_database_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-prod-database"
  vpc_id = module.lexicon_network.vpc_id
}

module "lexicon_bastion_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-bastion"
  vpc_id = module.lexicon_network.vpc_id
}

module "lexicon_load_balancer_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-alb"
  vpc_id = module.lexicon_network.vpc_id
}

moved {
  from = module.lexicon_database.aws_security_group.database
  to   = module.lexicon_database_security_group.aws_security_group.default
}

moved {
  from = module.lexicon_bastion.aws_security_group.bastion
  to   = module.lexicon_bastion_security_group.aws_security_group.default
}

moved {
  from = module.lexicon_load_balancer.aws_security_group.alb
  to   = module.lexicon_load_balancer_security_group.aws_security_group.default
}
