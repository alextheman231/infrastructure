resource "aws_elasticache_subnet_group" "lexicon" {
  name       = "lexicon-redis"
  subnet_ids = var.private_subnet_ids
}

module "redis" {
  source = "../../modules/aws/redis"

  name               = "lexicon-redis"
  port               = 6379
  security_group_ids = [module.redis_security_group.id]
  subnet_group_name  = aws_elasticache_subnet_group.lexicon.name
}
