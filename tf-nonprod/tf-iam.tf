resource "aws_iam_user" "tf-iam-ses" {
    name = "tf-ses"
}

resource "aws_iam_user" "tf-iam-cognito" {
    name = "tf-cognito"
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
        "ses:SendRawEmail"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user" "tf-github" {
    name = "tf-github"
}

#dev user
resource "aws_iam_group" "tf-developers" {
  name = "tf-developers"
  path = "/"
}

resource "aws_iam_user" "tf-developer" {
  name = "tf-developer"
}

resource "aws_iam_group_membership" "tf-tfdevelopers-members" {
  name = "tf-tfdevelopers-group-membership"

  users = [
    aws_iam_user.tf-developer.name
  ]

  group = aws_iam_group.tf-developers.name
}

resource "aws_iam_user_login_profile" "tf-developer" {
  user                    = aws_iam_user.tf-developer.name
  password_reset_required = false
}

#output "password" {
#  value     = aws_iam_user_login_profile.tf-developer.password
#  sensitive = false
#}
##

#ECS Roles

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment2" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = "${aws_iam_role.ecs_task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}