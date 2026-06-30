locals {
  backend_port = 8080
}

module "lexicon_network" {
  source = "../../modules/aws/network"
  name   = "lexicon"
}

module "lexicon_bastion" {
  source = "../../modules/aws/bastion"

  name           = "lexicon-bastion"
  public_ssh_key = var.public_ssh_key
  vpc_id         = module.lexicon_network.vpc_id
  subnet_id      = module.lexicon_network.public_subnet_ids[0]

  allowed_ipv4s = {
    alex_home = "81.103.172.13/32"
  }
}

module "lexicon_acm_certificate" {
  source                    = "../../modules/aws/acm_certificate"
  domain_name               = var.lexicon_domain
  subject_alternative_names = ["www.${var.lexicon_domain}"]
}

module "lexicon_dns_validation_records" {
  for_each = {
    for option in module.lexicon_acm_certificate.domain_validation_options :
    option.domain_name => option
  }

  source = "../../modules/cloudflare/dns"

  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  content = each.value.resource_record_value

  zone_id = var.cloudflare_lexicon_zone_id
  proxied = false
  ttl     = 660
}

module "lexicon_acm_certificate_validation" {
  source = "../../modules/aws/certificate_validation"

  certificate_arn = module.lexicon_acm_certificate.certificate_arn
  validation_record_fqdns = [
    for record in module.lexicon_dns_validation_records :
    record.fqdn
  ]
}

module "lexicon_load_balancer" {
  source = "../../modules/aws/alb"

  vpc_id            = module.lexicon_network.vpc_id
  subnet_ids        = module.lexicon_network.public_subnet_ids
  name              = "lexicon"
  health_check_path = "/api/v1"
  port              = local.backend_port
  certificate_arn   = module.lexicon_acm_certificate_validation.validated_certificate_arn
}

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

resource "aws_vpc_security_group_ingress_rule" "alb" {
  security_group_id = module.lexicon_ecs_service.security_group_id

  referenced_security_group_id = module.lexicon_load_balancer.security_group_id

  from_port   = local.backend_port
  to_port     = local.backend_port
  ip_protocol = "tcp"
}
