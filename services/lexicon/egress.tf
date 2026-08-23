module "all_egress_rule" {
  source = "../../modules/aws/security_group/egress_all"
  security_group_id_map = {
    database           = module.database_security_group.id
    session_management = module.session_management_security_group.id
    alb                = module.load_balancer_security_group.id
    ecs                = module.ecs_security_group.id
    redis              = module.redis_security_group.id
  }
}
