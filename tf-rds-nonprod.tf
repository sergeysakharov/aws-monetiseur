# https://www.terraform.io/docs/providers/aws/r/db_instance.html

data "aws_vpc" "default" {
  default = true
}
resource "random_string" "psql-nonprod-db-password" {
  length  = 32
  upper   = true
  numeric  = true
  special = false
}
resource "aws_security_group" "tf-sg-psql-nonprod" {
  vpc_id      = module.vpc-nonprod.vpc_id
  name     = "tf-sg-psql-nonprod"
  description = "Allow all inbound for Postgres"
ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_instance" "psql-nonprod" {
  identifier             = "psql-nonprod"
  db_name                = "psql-nonprod"
  instance_class         = "db.t3.micro"
  allocated_storage      = 30
  engine                 = "postgres"
  engine_version         = "14.6-R1"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.tf-sg-psql-nonprod.id]
  username               = "sameed"
  password               = "random_string.psql-nonprod-db-password.result}"
}

