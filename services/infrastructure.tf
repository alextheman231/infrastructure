module "tfe_organisation" {
  source            = "../modules/tfe/organisation"
  email             = var.alex_email
  organisation_name = var.tfe_organisation_name
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

module "terraform_plan_role" {
  source = "../modules/aws/terraform_role"

  oidc_provider_arn = aws_iam_openid_connect_provider.terraform.arn
  organization      = module.tfe_organisation.organisation_name
  project           = module.infrastructure_workspace.project_name
  workspace         = module.infrastructure_workspace.workspace_name

  role_name = "terraform-plan"
  run_phase = "plan"
}

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = module.terraform_plan_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

module "terraform_apply_role" {
  source = "../modules/aws/terraform_role"

  oidc_provider_arn = aws_iam_openid_connect_provider.terraform.arn
  organization      = module.tfe_organisation.organisation_name
  project           = module.infrastructure_workspace.project_name
  workspace         = module.infrastructure_workspace.workspace_name

  role_name = "terraform-apply"
  run_phase = "apply"
}

resource "aws_iam_role_policy_attachment" "administrator" {
  role       = module.terraform_apply_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "infrastructure_workspace" {
  source            = "../modules/tfe/workspace"
  name              = "infrastructure"
  organisation_name = var.tfe_organisation_name
  terraform_version = "~>1.15"
  environment_variables = {
    TFC_AWS_PROVIDER_AUTH  = "true"
    TFC_AWS_PLAN_ROLE_ARN  = module.terraform_plan_role.role_arn
    TFC_AWS_APPLY_ROLE_ARN = module.terraform_apply_role.role_arn
  }
}
