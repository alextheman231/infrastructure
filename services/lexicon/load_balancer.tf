module "acm_certificate" {
  source                    = "../../modules/aws/acm_certificate"
  domain_name               = var.lexicon_domain
  subject_alternative_names = ["www.${var.lexicon_domain}"]
}

module "dns_validation_records" {
  for_each = {
    for option in module.acm_certificate.domain_validation_options :
    option.domain_name => option
  }

  source = "../../modules/cloudflare/dns"

  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  content = each.value.resource_record_value

  zone_id = data.cloudflare_zone.lexicon_domain.zone_id
  proxied = false
  ttl     = 660
}

module "acm_certificate_validation" {
  source = "../../modules/aws/certificate_validation"

  certificate_arn = module.acm_certificate.certificate_arn
  validation_record_fqdns = [
    for record in module.dns_validation_records :
    record.fqdn
  ]
}

module "load_balancer" {
  source             = "../../modules/aws/load_balancer"
  name               = "lexicon"
  health_check_path  = "/api/v1"
  port               = local.backend_port
  certificate_arn    = module.acm_certificate_validation.validated_certificate_arn
  vpc_id             = var.vpc_id
  subnet_ids         = var.public_subnet_ids
  security_group_ids = [module.load_balancer_security_group.id]
}
