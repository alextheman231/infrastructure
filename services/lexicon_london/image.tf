module "lexicon_ecr_image" {
  source = "../../modules/aws/ecr"
  name   = "lexicon"
}
