module "lexicon_all_egress_rule" {
  source = "../../modules/aws/security_group/egress_all"
  security_group_id_map = {
    database = module.lexicon_database_security_group.id
    bastion  = module.lexicon_bastion_security_group.id
    alb      = module.lexicon_load_balancer_security_group.id
    ecs      = module.lexicon_ecs_security_group.id
  }
}
