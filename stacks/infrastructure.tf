module "tfe_organisation" {
  source            = "../modules/tfe/organisation"
  email             = var.alex_email
  organisation_name = var.tfe_organisation_name
}
module "infrastructure_workspace" {
  source            = "../modules/tfe/workspace"
  name              = "infrastructure"
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
    TFE_TOKEN  = var.tfe_token
    PASSPHRASE = var.tf_via_pr_passphrase
  }
}
