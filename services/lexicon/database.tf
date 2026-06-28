module "lexicon_database" {
  source                    = "../../modules/aws/database"
  initial_db_name           = "lexicon"
  db_identifier             = "lexicon-prod"
  postgres_version          = "18"
  username                  = "lexicon_user"
  password                  = var.lexicon_database_password
  bastion_security_group_id = module.lexicon_bastion.security_group_id
}

moved {
  from = module.lexicon_database_aws
  to   = module.lexicon_database
}
