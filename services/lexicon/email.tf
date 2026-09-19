module "ses_identity" {
  source = "../../modules/aws/ses_identity"

  domain_name = var.lexicon_domain
}

module "ses_dkim_records" {
  for_each = toset(module.ses_identity.dkim_tokens)
  source   = "../../modules/cloudflare/dns"

  name    = "${each.value}._domainkey.${var.lexicon_domain}"
  type    = "CNAME"
  content = "${each.value}.dkim.amazonses.com"

  zone_id = data.cloudflare_zone.lexicon_domain.zone_id
  proxied = false
  ttl     = 660
}

module "ses_mx_record" {
  source = "../../modules/cloudflare/dns"

  name    = var.lexicon_domain
  type    = "MX"
  content = "inbound-smtp.${var.aws_region}.amazonaws.com"

  zone_id  = data.cloudflare_zone.lexicon_domain.zone_id
  proxied  = false
  ttl      = 660
  priority = 10
}

module "s3_email_bucket" {
  source = "../../modules/aws/s3_bucket"

  name = "lexicon-emails"
}

module "email_bucket_guardduty" {
  source = "../../modules/aws/guardduty"

  guardduty_detector_id        = var.guardduty_detector_id
  malware_protection_role_name = "lexicon-emails-guardduty-malware-protection"
  s3_bucket_arn                = module.s3_email_bucket.arn
  s3_bucket_name               = module.s3_email_bucket.name
}

data "aws_caller_identity" "current" {}

module "receipt_rule" {
  source = "../../modules/aws/receipt_rule"

  name           = "lexicon-emails-receipt-rule"
  rule_set_name  = var.receipt_rule_set_name
  recipients     = ["social@${var.lexicon_domain}"]
  s3_bucket_name = module.s3_email_bucket.name
  position       = 1
  ses_account_id = data.aws_caller_identity.current.account_id
}
