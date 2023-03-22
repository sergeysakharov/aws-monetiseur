resource "aws_elasticache_cluster" "tf-redis-dev-nonprod" {
  cluster_id           = "tf-redis-dev-nonprod"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
}