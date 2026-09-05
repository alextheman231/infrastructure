module "ses_identity" {
  source = "../../modules/aws/ses_identity"

  domain_name = var.lexicon_domain
}
