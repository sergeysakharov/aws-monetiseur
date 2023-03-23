module "tf-ecs-cluster-nonprod" {
  source = "infrablocks/ecs-cluster/aws"
  version = "6.0.0"

  region = "eu-west-3"
  vpc_id = module.vpc-nonprod.vpc_id
  subnet_ids = module.vpc-nonprod.private_subnets

  component = "tf"
  deployment_identifier = ""
  associate_public_ip_addresses = true
  cluster_name = "ecs-nonprod"
#  cluster_instance_ssh_public_key_path = "~/.ssh/id_rsa.pub"
  cluster_instance_type = "t3a.small"
  enable_container_insights = true
  cluster_minimum_size = 1
  cluster_maximum_size = 1
  cluster_desired_capacity = 1
  include_asg_capacity_provider = true
  asg_capacity_provider_manage_scaling = true
 
 
  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }

}
#