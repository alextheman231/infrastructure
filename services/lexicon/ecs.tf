module "lexicon_ecr_image" {
  source = "../../modules/aws/ecr"
  name   = "lexicon"
}

module "lexicon_ecs_task_execution_role" {
  source      = "../../modules/aws/roles/ecs_task_execution"
  name        = "lexicon"
  secret_arns = module.lexicon_secrets.secret_arns
}

module "lexicon_ecs_service" {
  source = "../../modules/aws/ecs"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids
  name       = "lexicon"
  image      = module.lexicon_ecr_image.repository_url
  port       = local.backend_port
  environment_variables = {
    NODE_ENV         = "production"
    API_BASE_URL     = "https://${var.lexicon_domain}"
    ALLOWED_ORIGINS  = "https://${var.lexicon_domain}"
    GOOGLE_CLIENT_ID = var.lexicon_google_client_id
  }
  secret_arns     = module.lexicon_secrets.secret_arns
  fargate_version = "1.4.0"

  task_definitions = [{
    name = "service"
    },
    {
      name    = "migrate"
      command = ["pnpm", "--dir", "apps/back-end", "run", "migrate-db"]
    }
  ]

  target_group_arn   = module.lexicon_load_balancer.target_group_arn
  lb_listener_arn    = module.lexicon_load_balancer.listener_arn
  assign_public_ip   = true
  region             = var.aws_region
  execution_role_arn = module.lexicon_ecs_task_execution_role.role_arn
}

resource "aws_vpc_security_group_ingress_rule" "ecs" {
  security_group_id = module.lexicon_database.security_group_id

  referenced_security_group_id = module.lexicon_ecs_service.security_group_id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}
