module "lexicon_ecs_task_execution_role" {
  source      = "../../modules/aws/roles/ecs_task_execution"
  name        = "lexicon"
  secret_arns = module.lexicon_secrets.secret_arns
}

module "lexicon_ecs_task_role" {
  source = "../../modules/aws/roles/ecs_task"

  name           = "lexicon"
  s3_bucket_arns = [module.file_store_prod.arn, module.file_store_dev.arn]
}

module "lexicon_ecs_service" {
  source = "../../modules/aws/ecs"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  name       = "lexicon"
  image      = module.lexicon_ecr_image.repository_url
  port       = local.backend_port
  environment_variables = {
    NODE_ENV         = "production"
    API_BASE_URL     = "https://${var.lexicon_domain}"
    GOOGLE_CLIENT_ID = var.lexicon_google_client_id
    SENTRY_DSN       = module.lexicon_sentry_back_end.public_dsn
    REDIS_URL        = module.redis.endpoint
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
  region = var.aws_region

  target_group_arn   = module.lexicon_load_balancer.target_group_arn
  lb_listener_arn    = module.lexicon_load_balancer.listener_arn
  execution_role_arn = module.lexicon_ecs_task_execution_role.role_arn
  task_role_arn      = module.lexicon_ecs_task_role.role_arn
  security_group_ids = [module.lexicon_ecs_security_group.id]
}
