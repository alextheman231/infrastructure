module "database" {
  source             = "../../modules/aws/database"
  initial_db_name    = "lexicon"
  db_identifier      = "lexicon-prod"
  postgres_version   = "18"
  username           = "lexicon_user"
  password           = var.lexicon_database_password
  security_group_ids = [module.database_security_group.id]
  subnet_ids         = var.private_subnet_ids
}

moved {
  from = module.lexicon_database
  to   = module.database
}
