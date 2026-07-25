module "file_store" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-files"
}

module "file_store_dev" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-files-dev"
}
