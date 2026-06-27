terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=5.0.0"
    }
  }
}

resource "cloudflare_dns_record" "default" {
  name = contains(["CNAME", "MX", "NS"], var.type) ? trimsuffix(var.name, ".") : var.name

  ttl     = var.ttl
  type    = var.type
  zone_id = var.zone_id
  content = (
    var.type == "TXT"
    ? join(" ", formatlist("\"%s\"", regexall("(?s).{1,255}", var.content)))
    : contains(["CNAME", "MX", "NS"], var.type)
    ? trimsuffix(var.content, ".")
    : var.content
  )
  proxied = var.proxied
}
