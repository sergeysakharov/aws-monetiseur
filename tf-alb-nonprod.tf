module "tf-alb-nonprod" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "tf-alb-nonprod"

  load_balancer_type = "application"

  vpc_id             = module.vpc-nonprod.vpc_id
  subnets            = module.vpc-nonprod.public_subnets
  security_groups    = [module.tf-sg-alb-nonprod.security_group_id]
  
  #access_logs = {
  #  bucket = "my-alb-logs"
  #}

  target_groups = [
    {
      name_prefix      = "tf-0-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
  #      {
  #        target_id = "i-0123456789abcdefg"
  #        port = 80
  #      },
  #      {
  #        target_id = "i-a1b2c3d4e5f6g7h8i"
  #        port = 8080
  #      }
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:eu-west-3:938978445243:certificate/5913635c-9c10-4f54-9054-8fa55059e3b3"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}