module "sg-ecs-dev" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "tf-sg-ecs-dev"
  vpc_id      = module.vpc-dev.vpc_id

  ingress_cidr_blocks      = ["10.0.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.0.0.0/16"
    },
    {
      rule        = "redis-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "smtps-465-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = {
    project = "tf testing"
    Terraform   = "true"
    Environment = var.env
  }
}
