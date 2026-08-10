resource "aws_cloudwatch_log_group" "redis" {
  name              = var.name
  retention_in_days = 30
}

resource "aws_elasticache_cluster" "default" {
  cluster_id         = var.name
  engine             = "redis"
  node_type          = var.node_type
  num_cache_nodes    = 1
  port               = var.port
  apply_immediately  = true
  security_group_ids = var.security_group_ids
  subnet_group_name  = var.subnet_group_name

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
}
