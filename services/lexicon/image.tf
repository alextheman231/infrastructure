module "ecr_image" {
  source = "../../modules/aws/ecr"
  name   = "lexicon"
}
