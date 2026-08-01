module "aws_network" {
  source = "../modules/aws/network"
  name   = "alextheman231"
}

moved {
  from = module.lexicon.module.lexicon_network
  to   = module.aws_network
}

moved {
  from = module.aws_network.aws_db_subnet_group.default
  to   = module.lexicon.module.lexicon_database.aws_db_subnet_group.default
}
