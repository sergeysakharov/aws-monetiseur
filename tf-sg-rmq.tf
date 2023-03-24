module "tf-sg-rmq-nonprod" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "tf-sg-rmq-nonprod"
  vpc_id      = module.vpc-nonprod.vpc_id

  egress_cidr_blocks       = ["0.0.0.0/0"]
  egress_rules             = ["all-all"]
 
  ingress_with_cidr_blocks = [
    {
      rule        = "rabbitmq-5672-tcp"
      cidr_blocks = "10.0.0.0/16"
    },
    {
      rule        = "rabbitmq-5672-tcp"
      cidr_blocks = "15.188.231.122/32"
    },
    {
      rule        = "rabbitmq-5672-tcp"
      cidr_blocks = "35.181.70.198/32"
    },

  ]
  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}
