#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster

resource "aws_elasticache_cluster" "tf-redis-dev-nonprod" {
  cluster_id           = "tf-redis-dev-nonprod"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  subnet_group_name    = [aws_elasticache_subnet_group.tf-redis-subnet-group]

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }

}

resource "aws_subnet" "tf-redis-subnet" {
  vpc_id            = module.vpc-nonprod.vpc_id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}

resource "aws_elasticache_subnet_group" "tf-redis-subnet-group" {
  name       = "tf-redis-subnet-group"
  subnet_ids = [aws_subnet.tf-redis-subnet.id]
  
  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }

}