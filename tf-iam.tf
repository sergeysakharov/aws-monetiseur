resource "aws_iam_user" "tf-iam-ses" {
    name = "tf-ses"
}

resource "aws_iam_user_policy" "tf-iam-ses-policy" {
#  count = length(var.username)
  name = "tf-iam-ses-policy"
  user = "tf-ses"
policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}