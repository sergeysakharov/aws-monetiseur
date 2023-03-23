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

resource "aws_s3_bucket" "mmm1example" {
  bucket = "mmm1-example"
}

resource "aws_s3_bucket_public_access_block" "mmm1example" {
  bucket = aws_s3_bucket.mmm1example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "mmm1example-policy" {
  bucket = aws_s3_bucket.mmm1example.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::mmm1-example/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
      }
    }
  ]
}
POLICY
}