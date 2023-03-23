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
resource "aws_iam_group" "developers" {
  name = "tf-developers"
  path = "/"
}

#data "aws_iam_policy" "administrator_access" {
#  name = "AdministratorAccess"
#}

#resource "aws_iam_group_policy_attachment" "developers" {
#  group      = aws_iam_group.developers.name
#  policy_arn = data.aws_iam_policy.administrator_access.arn
#}

resource "aws_iam_user" "developer" {
  name = "tf-developer"
}

resource "aws_iam_user_group_membership" "devstream" {
  user   = aws_iam_user.developer.name
  groups = [aws_iam_group.developers.name]
}

resource "aws_iam_user_login_profile" "developer" {
  user                    = aws_iam_user.developer.name
  password_reset_required = false
}

output "password" {
  value     = aws_iam_user_login_profile.developer.password
  sensitive = false
}



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
resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = "${aws_iam_role.ecs_task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}