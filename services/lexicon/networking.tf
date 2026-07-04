locals {
  backend_port = 8080
}

module "lexicon_bastion" {
  source = "../../modules/aws/bastion"
  name   = "lexicon-bastion"
  allowed_ipv4s = {
    alex_home = "81.103.172.13/32"
  }
  public_ssh_key = var.public_ssh_key
  vpc_id         = data.aws_vpc.default.id
  subnet_id      = data.aws_subnets.default.ids[0]
}

module "lexicon_acm_certificate" {
  source                    = "../../modules/aws/acm_certificate"
  domain_name               = var.lexicon_domain
  subject_alternative_names = ["www.${var.lexicon_domain}"]
}

module "lexicon_load_balancer" {
  source            = "../../modules/aws/alb"
  name              = "lexicon"
  health_check_path = "/api/v1"
  port              = local.backend_port
  certificate_arn   = module.lexicon_acm_certificate.certificate_arn
  vpc_id            = data.aws_vpc.default.id
  subnet_ids        = data.aws_subnets.default.ids
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
