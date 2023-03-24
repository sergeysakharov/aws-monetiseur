module "tf-sg-alb-nonprod" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "tf-sg-alb-nonprod"
  vpc_id      = module.vpc-nonprod.vpc_id

  egress_cidr_blocks       = ["0.0.0.0/0"]
  egress_rules             = ["all-all"]
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp", "http-80-tcp"]

#  ingress_with_cidr_blocks = [
#    {
#      from_port   = 8080
#      to_port     = 8090
#      protocol    = "tcp"
#      description = "User-service ports"
#      cidr_blocks = "10.0.0.0/16"
#    },
#    {
#      rule        = "redis-tcp"
#      cidr_blocks = "0.0.0.0/0"
#    },
#    {
#      rule        = "smtps-465-tcp"
#      cidr_blocks = "0.0.0.0/0"
#    },
#  ]

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}
