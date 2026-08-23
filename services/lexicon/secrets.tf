module "secrets" {
  source = "../../modules/aws/secrets_manager"
  name   = "lexicon"
  secrets = {
    DATABASE_URL         = module.database.database_url
    GOOGLE_CLIENT_SECRET = var.lexicon_google_client_secret
  }
  plan_role_id = var.plan_role_id
  allowed_role_ids = {
    ecs_task_execution = module.ecs_task_execution_role.role_id
  }
}

moved {
  from = module.lexicon_secrets
  to   = module.secrets
}
