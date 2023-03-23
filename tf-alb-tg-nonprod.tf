resource "aws_lb_target_group" "tf-alb-tgdefault-nonprod" {
  name        = "tf-alb-tgdefault-nonprod"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = module.vpc-nonprod.vpc_id
}