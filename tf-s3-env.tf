#https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest

module "s3-bucket-env" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "s3-${var.project}-env"
  acl    = "private"

  versioning = {
    enabled = true
  }

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }

}