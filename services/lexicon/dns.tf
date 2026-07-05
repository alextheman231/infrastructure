module "lexicon_dns_record" {
  source = "../../modules/cloudflare/dns"
  for_each = toset([
    var.lexicon_domain,
    "www.${var.lexicon_domain}"
  ])

  name    = each.value
  type    = "CNAME"
  zone_id = var.cloudflare_lexicon_zone_id
  content = module.lexicon_load_balancer.dns_name
}
