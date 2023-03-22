module "vpc-nonprod" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-nonprod"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-3a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = var.env.nonprod
    Project = var.project
  }
}
##
