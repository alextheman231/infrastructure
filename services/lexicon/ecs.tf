module "lexicon_image" {
  source      = "../../modules/docker"
  namespace   = var.docker_username
  name        = "lexicon"
  description = "Dockerhub repository for the Lexicon back-end server image."
}

module "lexicon_ecs_service" {
  source = "../../modules/aws/ecs"
  name   = "lexicon"
  image  = module.lexicon_image.image_name
  port   = local.backend_port
  environment_variables = {
    DATABASE_URL         = module.lexicon_database_aws.database_url
    NODE_ENV             = "production"
    API_BASE_URL         = "https://${var.lexicon_domain}"
    ALLOWED_ORIGINS      = "https://${var.lexicon_domain}"
    GOOGLE_CLIENT_ID     = var.lexicon_google_client_id
    GOOGLE_CLIENT_SECRET = var.lexicon_google_client_secret
    SENTRY_DSN           = var.lexicon_back_end_sentry_dsn
  }
  fargate_version = "1.4.0"

  task_definitions = [{
    name = "service"
    },
    {
      name    = "migrate"
      command = ["pnpm", "--dir", "apps/back-end", "run", "migrate-db"]
    }
  ]

  target_group_arn = module.lexicon_load_balancer.target_group_arn
  lb_listener_arn  = module.lexicon_load_balancer.listener_arn
}

resource "aws_vpc_security_group_ingress_rule" "ecs" {
  security_group_id = module.lexicon_database_aws.security_group_id

  referenced_security_group_id = module.lexicon_ecs_service.security_group_id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}
