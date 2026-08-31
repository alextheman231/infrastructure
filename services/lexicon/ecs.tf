module "ecs_task_execution_role" {
  source      = "../../modules/aws/iam/roles/ecs_task_execution"
  name        = "lexicon"
  secret_arns = module.secrets.secret_arns
}

module "ecs_task_role" {
  source = "../../modules/aws/iam/roles/ecs_task"

  name           = "lexicon"
  s3_bucket_arns = [module.file_store_prod.arn, module.file_store_dev.arn]
}

module "ecs_cluster" {
  source = "../../modules/aws/ecs_cluster"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  name       = "lexicon"
  image      = module.ecr_image.repository_url

  environment_variables = {
    NODE_ENV               = "production"
    API_BASE_URL           = "https://${var.lexicon_domain}"
    GOOGLE_CLIENT_ID       = var.lexicon_google_client_id
    SENTRY_DSN             = module.sentry_back_end.public_dsn
    VITE_SENTRY_DSN        = module.sentry_front_end.public_dsn
    REDIS_URL              = module.redis.endpoint
    FILE_STORE_BUCKET_NAME = module.file_store_prod.name
  }

  secret_arns     = module.secrets.secret_arns
  fargate_version = "1.4.0"

  task_definitions = {
    app = {
      is_long_running  = true
      target_group_arn = module.load_balancer.target_group_arn
      port             = local.backend_port
    },
    workers = {
      is_long_running = true
      command         = ["pnpm", "--dir", "apps/back-end", "run", "workers"]
    },
    migrate = {
      is_long_running = false
      command         = ["pnpm", "--dir", "apps/back-end", "run", "migrate-db"]
    }
  }
  region             = var.aws_region
  execution_role_arn = module.ecs_task_execution_role.role_arn
  task_role_arn      = module.ecs_task_role.role_arn
  security_group_ids = [module.ecs_security_group.id]
}
