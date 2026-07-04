terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    sentry = {
      source  = "jianyuan/sentry"
      version = ">=0.14.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=5.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
}

moved {
  from = module.lexicon_ecs_service.aws_iam_role.ecs_task_execution
  to   = module.lexicon_ecs_task_execution_role.aws_iam_role.ecs_task_execution
}
