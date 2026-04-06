module "tfe_organisation" {
  source            = "./modules/tfe/organisation"
  email             = var.alex_email
  organisation_name = var.tfe_organisation_name
}
module "infrastructure_workspace" {
  source            = "./modules/tfe/workspace"
  name              = "infrastructure"
  organisation_name = var.tfe_organisation_name
}

