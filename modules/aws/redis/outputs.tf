output "endpoint" {
  value = "redis://${aws_elasticache_cluster.default.cache_nodes[0].address}"
}
