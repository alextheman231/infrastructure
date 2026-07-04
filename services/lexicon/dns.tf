module "lexicon_dns_record" {
  source = "../../modules/cloudflare/dns"

  name    = var.lexicon_domain
  type    = "CNAME"
  zone_id = var.cloudflare_lexicon_zone_id
  content = module.lexicon_load_balancer.dns_name
}

module "lexicon_dns_record_www" {
  source = "../../modules/cloudflare/dns"

  name    = "www.${var.lexicon_domain}"
  type    = "CNAME"
  zone_id = var.cloudflare_lexicon_zone_id
  content = module.lexicon_load_balancer.dns_name
}
