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
