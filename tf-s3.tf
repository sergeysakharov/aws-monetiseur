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

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.mmm1example.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
        "*"
    }

    actions = [
                "s3:GetObject",
                "s3:GetObjectVersion",
    ]

    resources = [
      aws_s3_bucket.mmm1example.arn,
      "${aws_s3_bucket.mmm1example.arn}/*",
    ]
  }
}