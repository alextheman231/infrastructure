module "lexicon_repository" {
  source             = "../../modules/github/repository"
  name               = "lexicon"
  description        = "The true successor to Neurosongs, allowing users to write blogs, share them, and track revision history."
  visibility         = "public"
  required_ci_checks = var.required_ci_checks
  alex_up_bot_app_id = var.alex_up_bot_app_id
  secrets = {
    RENDER_DEPLOY_KEY = var.lexicon_render_key
    DATABASE_URL      = var.lexicon_database_url_encrypted
    DOCKER_PAT        = var.docker_pat_lexicon_encrypted
  }
  variables = {
    AWS_ROLE_ARN              = module.lexicon_deployment_role.role_arn
    AWS_CLUSTER_NAME          = module.lexicon_ecs_service.cluster_name
    AWS_SERVICE_NAME          = module.lexicon_ecs_service.service_name
    AWS_MIGRATION_TASK_FAMILY = module.lexicon_ecs_service.task_families["migrate"]
    AWS_REGION                = var.aws_region
    AWS_SECURITY_GROUP_ID     = module.lexicon_ecs_service.security_group_id
    AWS_SUBNET_IDS            = join(",", module.lexicon_ecs_service.subnet_ids)
    AWS_ASSIGN_PUBLIC_IP      = module.lexicon_ecs_service.assign_public_ip ? "ENABLED" : "DISABLED"
    VITE_API_BASE_URL         = "https://${var.lexicon_api_domain}"
    RENDER_SERVICE_ID         = var.lexicon_render_service_id
    DOCKER_USERNAME           = var.docker_username
    FRONT_END_SENTRY_DSN      = var.lexicon_front_end_sentry_dsn
  }
  labels = var.github_labels
}

module "lexicon_deployment_role" {
  source            = "../../modules/aws/github_role"
  repository        = "alextheman231/lexicon"
  role_name         = "lexicon-deployment"
  oidc_provider_arn = var.deployment_role_oidc_provider_arn
  policy_json       = data.aws_iam_policy_document.lexicon_deploy.json
}

data "aws_iam_policy_document" "lexicon_deploy" {
  statement {
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:UpdateService",
      "ecs:RunTask",
      "ecs:DescribeTasks",
      "ecs:DescribeClusters"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      module.lexicon_ecs_service.execution_role_arn
    ]
  }
}
