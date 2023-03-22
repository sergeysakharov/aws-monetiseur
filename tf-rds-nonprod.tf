# https://www.terraform.io/docs/providers/aws/r/db_instance.html

data "aws_vpc" "default" {
  default = true
}
resource "random_string" "uddin-db-password" {
  length  = 32
  upper   = true
  numeric  = true
  special = false
}
resource "aws_security_group" "uddin" {
  vpc_id      = module.vpc-nonprod.vpc_id
  db_name     = "psql-nonprod"
  description = "Allow all inbound for Postgres"
ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_instance" "uddin-sameed" {
  identifier             = "uddin-sameed"
  db_name                = "psql-nonprod"
  instance_class         = "db.t2.micro"
  allocated_storage      = 30
  engine                 = "postgres"
  engine_version         = "12.5"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.uddin.id]
  username               = "sameed"
  password               = "random_string.uddin-db-password.result}"
}

