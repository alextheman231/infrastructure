module "tfe_organisation" {
  source            = "../modules/tfe/organisation"
  email             = var.alex_email
  organisation_name = var.tfe_organisation_name
}
module "infrastructure_workspace" {
  source            = "../modules/tfe/workspace"
  name              = "infrastructure"
  organisation_name = var.tfe_organisation_name
  terraform_version = "~>1.15"
}

module "infrastructure_repository" {
  source      = "../modules/github/repository"
  name        = "infrastructure"
  description = "Infrastructure for my GitHub repositories."
  visibility  = "public"
  required_ci_checks = concat(local.check_list.base, [
    local.check_name.terraform.lint_ci,
    local.check_name.terraform.plan_ci,
    local.check_name.terraform.comment_plan
  ])
  alex_up_bot_app_id = var.alex_up_bot_app_id
  secrets = {
    TFE_TOKEN = var.tfe_token
  }
  labels = merge(local.labels.standard, local.labels.infrastructure)
}

data "aws_iam_policy_document" "terraform_plan" {
  statement {
    effect = "Allow"

    actions = [
      "Describe*",
      "List*",
      "Get*"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = ["*"]
  }
}

module "terraform_plan_role" {
  source = "../modules/aws/terraform_role"

  oidc_provider_arn = aws_iam_openid_connect_provider.terraform.arn
  organization      = module.tfe_organisation.organisation_name
  project           = module.infrastructure_workspace.project_name
  workspace         = module.infrastructure_workspace.workspace_name

  role_name   = "terraform-plan"
  run_phase   = "plan"
  policy_json = data.aws_iam_policy_document.terraform_plan.json
}

data "aws_iam_policy_document" "terraform_apply" {
  statement {
    effect = "Allow"

    actions = [
      "Describe*",
      "List*",
      "Get*",
      "Create*",
      "Update*",
      "Delete*"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = ["*"]
  }
}

module "terraform_apply_role" {
  source = "../modules/aws/terraform_role"

  oidc_provider_arn = aws_iam_openid_connect_provider.terraform.arn
  organization      = module.tfe_organisation.organisation_name
  project           = module.infrastructure_workspace.project_name
  workspace         = module.infrastructure_workspace.workspace_name

  role_name   = "terraform-apply"
  run_phase   = "apply"
  policy_json = data.aws_iam_policy_document.terraform_apply.json
}
