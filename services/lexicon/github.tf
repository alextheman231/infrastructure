module "repository" {
  source             = "../../modules/github/repository"
  name               = "lexicon"
  description        = "The true successor to Neurosongs, allowing users to write blogs, share them, and track revision history."
  visibility         = "public"
  required_ci_checks = var.required_ci_checks
  alex_up_bot_app_id = var.alex_up_bot_app_id
  variables = {
    AWS_ROLE_ARN              = module.deployment_role.role_arn
    AWS_CLUSTER_NAME          = module.ecs_service.cluster_name
    AWS_SERVICE_NAME          = module.ecs_service.service_name
    AWS_MIGRATION_TASK_FAMILY = module.ecs_service.task_families["migrate"]
    AWS_REGION                = var.aws_region
    AWS_SECURITY_GROUP_ID     = module.ecs_security_group.id
    AWS_SUBNET_IDS            = join(",", module.ecs_service.subnet_ids)
    AWS_ASSIGN_PUBLIC_IP      = module.ecs_service.assign_public_ip ? "ENABLED" : "DISABLED"
    AWS_ECR_REPOSITORY_URL    = module.ecr_image.repository_url
    FRONT_END_SENTRY_DSN      = module.sentry_front_end.public_dsn
  }
  labels = var.github_labels
}

moved {
  from = module.lexicon_repository
  to   = module.repository
}

data "aws_iam_policy_document" "deploy" {
  statement {
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:UpdateService",
      "ecs:RunTask",
      "ecs:DescribeTasks",
      "ecs:DescribeClusters",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      module.ecs_task_execution_role.role_arn,
      module.ecs_task_role.role_arn
    ]
  }
}

module "deployment_role" {
  source            = "../../modules/aws/iam/roles/github"
  repository        = module.repository.full_name
  role_name         = "lexicon-deployment"
  oidc_provider_arn = var.deployment_role_oidc_provider_arn
  policy_json       = data.aws_iam_policy_document.deploy.json
}

moved {
  from = module.lexicon_deployment_role
  to   = module.deployment_role
}
