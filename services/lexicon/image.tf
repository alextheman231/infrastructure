module "ecr_image" {
  source = "../../modules/aws/ecr"
  name   = "lexicon"
}

moved {
  from = module.lexicon_ecr_image
  to   = module.ecr_image
}
