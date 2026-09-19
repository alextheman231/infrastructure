module "file_store_prod" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-files-prod"
}

module "file_store_prod_guardduty" {
  source = "../../modules/aws/guardduty"

  guardduty_detector_id        = var.guardduty_detector_id
  malware_protection_role_name = "lexicon-files-prod-guardduty-malware-protection"
  s3_bucket_arn                = module.file_store_prod.arn
  s3_bucket_name               = module.file_store_prod.name
}

module "file_store_dev" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-files-dev"
}
