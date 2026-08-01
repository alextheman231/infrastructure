module "aws_network" {
  source = "../modules/aws/network"
  name   = "alextheman231"
}

moved {
  from = module.lexicon.module.lexicon_network
  to   = module.aws_network
}
