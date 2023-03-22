#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster

resource "aws_elasticache_cluster" "tf-redis-dev-nonprod" {
  cluster_id           = "tf-redis-dev-nonprod"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  subnet_group_name    = module.vpc-nonprod.private_subnets
}