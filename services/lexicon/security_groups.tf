module "lexicon_database_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-prod-database"
  vpc_id = var.vpc_id
}

module "lexicon_session_management_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-session-management"
  vpc_id = var.vpc_id
}

module "lexicon_load_balancer_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-alb"
  vpc_id = var.vpc_id
}

module "lexicon_ecs_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-ecs"
  vpc_id = var.vpc_id
}

module "redis_security_group" {
  source = "../../modules/aws/security_group"

  name   = "lexicon-redis"
  vpc_id = var.vpc_id
}
