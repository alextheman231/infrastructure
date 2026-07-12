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
  source             = "../../modules/aws/alb"
  name               = "lexicon"
  health_check_path  = "/api/v1"
  port               = local.backend_port
  certificate_arn    = module.lexicon_acm_certificate_validation.validated_certificate_arn
  vpc_id             = module.lexicon_network.vpc_id
  subnet_ids         = module.lexicon_network.public_subnet_ids
  security_group_ids = [module.lexicon_load_balancer_security_group.id]
}
