#URL: https://github.com/hashicorp/learn-terraform-rds
data "aws_availability_zones" "available" {}

resource "aws_db_subnet_group" "tf-rds-nonprod-subnet-group" {
  name       = "tf-rds-nonprod-subnet-group"
  subnet_ids = module.vpc-nonprod.public_subnets

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}

resource "aws_security_group" "tf-sg-rds-nonprod" {
  name   = "tf-sg-rds-nonprod"
  vpc_id = module.vpc-nonprod.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}

resource "aws_db_parameter_group" "tf-rds-nonprod-param-group" {
  name   = "tf-rds-nonprod-param-group"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
    tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }
}

resource "aws_db_instance" "tf-rds-nonprod" {
  identifier             = "tf-rds-nonprod"
  instance_class         = "db.t3.micro"
  allocated_storage      = 30
  engine                 = "postgres"
  engine_version         = "14.7"
  username               = "psqladmin"
  password               = var.pgsql-nonprod-password
  db_subnet_group_name   = aws_db_subnet_group.tf-rds-nonprod-subnet-group.name
  vpc_security_group_ids = [aws_security_group.tf-sg-rds-nonprod.id]
  parameter_group_name   = aws_db_parameter_group.tf-rds-nonprod-param-group.name
  publicly_accessible    = true
  skip_final_snapshot    = true

  tags = {
    Terraform = "true"
    Environment = var.envnonprod
    Project = var.project
  }

}