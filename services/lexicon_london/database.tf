# module "lexicon_database" {
#   source                    = "../../modules/aws/database"
#   initial_db_name           = "lexicon"
#   db_identifier             = "lexicon-prod"
#   postgres_version          = "18"
#   username                  = "lexicon_user"
#   password                  = var.lexicon_database_password
#   bastion_security_group_id = module.lexicon_bastion.security_group_id
#   vpc_id                    = module.lexicon_network.vpc_id
#   db_subnet_group_name      = module.lexicon_network.public_subnet_group_name
# }
