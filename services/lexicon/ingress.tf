resource "aws_vpc_security_group_ingress_rule" "session_management_to_database" {
  security_group_id = module.lexicon_database_security_group.id

  referenced_security_group_id = module.lexicon_session_management_security_group.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "alb_to_ecs" {
  security_group_id = module.lexicon_ecs_security_group.id

  referenced_security_group_id = module.lexicon_load_balancer_security_group.id

  from_port   = local.backend_port
  to_port     = local.backend_port
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ecs_to_database" {
  security_group_id = module.lexicon_database_security_group.id

  referenced_security_group_id = module.lexicon_ecs_security_group.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = module.lexicon_load_balancer_security_group.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = module.lexicon_load_balancer_security_group.id

  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "redis" {
  security_group_id = module.redis_security_group.id

  referenced_security_group_id = module.lexicon_ecs_security_group.id

  from_port   = 6379
  to_port     = 6379
  ip_protocol = "tcp"
}
