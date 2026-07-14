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

module "lexicon_ecs_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-ecs"
  vpc_id = module.lexicon_network.vpc_id
}

moved {
  from = module.lexicon_ecs_service.aws_security_group.ecs
  to   = module.lexicon_ecs_security_group.aws_security_group.default
}
