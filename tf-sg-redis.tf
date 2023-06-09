module "tf-sg-redis-nonprod" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "tf-sg-redis-nonprod"
  vpc_id      = module.vpc-nonprod.vpc_id

#  ingress_cidr_blocks      = ["10.0.0.0/16"]
#  ingress_rules            = ["https-443-tcp"]
  egress_cidr_blocks       = ["0.0.0.0/0"]
  egress_rules             = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      rule        = "redis-tcp"
      cidr_blocks = "10.0.0.0/16"
    },
  ]
  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}
