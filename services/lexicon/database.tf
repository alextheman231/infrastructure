module "lexicon_database" {
  source               = "../../modules/aws/database"
  initial_db_name      = "lexicon"
  db_identifier        = "lexicon-prod"
  postgres_version     = "18"
  username             = "lexicon_user"
  password             = var.lexicon_database_password
  db_subnet_group_name = module.lexicon_network.db_subnet_group_name
  security_group_ids   = [module.lexicon_database_security_group.id]
}
