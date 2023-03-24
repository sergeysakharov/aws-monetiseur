#https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest

resource "aws_s3_bucket" "tf-s3-monetiseur-env" {
  bucket = "tf-s3-monetiseur-env"
}

resource "aws_s3_bucket_public_access_block" "tf-s3-monetiseur-env-access" {
  bucket = aws_s3_bucket.tf-s3-monetiseur-env.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}