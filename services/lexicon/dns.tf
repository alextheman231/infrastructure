data "cloudflare_zone" "lexicon_domain" {
  filter = {
    name = var.lexicon_domain
  }
}

module "lexicon_dns_record" {
  source = "../../modules/cloudflare/dns"
  for_each = toset([
    var.lexicon_domain,
    "www.${var.lexicon_domain}"
  ])

  name    = each.value
  type    = "CNAME"
  zone_id = data.cloudflare_zone.lexicon_domain.zone_id
  content = module.lexicon_load_balancer.dns_name
}

resource "cloudflare_zone_dnssec" "lexicon_domain" {
  zone_id = data.cloudflare_zone.lexicon_domain.zone_id
  status  = "active"
}
