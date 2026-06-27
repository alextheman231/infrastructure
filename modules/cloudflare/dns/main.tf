terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=5.0.0"
    }
  }
}

resource "cloudflare_dns_record" "default" {
  name    = var.name
  ttl     = var.ttl
  type    = var.type
  zone_id = var.zone_id
  content = var.content
  proxied = var.proxied
}
