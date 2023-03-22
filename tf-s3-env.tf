#https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest

module "s3_bucket-env" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "env"
  acl    = "private"

  versioning = {
    enabled = true
  }

}