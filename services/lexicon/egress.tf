module "lexicon_all_egress_rule" {
  source = "../../modules/aws/security_group/egress_all"
  security_group_id_map = {
    database           = module.lexicon_database_security_group.id
    session_management = module.lexicon_session_management_security_group.id
    alb                = module.lexicon_load_balancer_security_group.id
    ecs                = module.lexicon_ecs_security_group.id
  }
}
