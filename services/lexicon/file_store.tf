module "file_store_prod" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-files-prod"
}

module "file_store_dev" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-files-dev"
}
