module "tf-rmq-nonprod" {
  source  = "mhmdio/rabbitmq/aws"
  version = "0.1.0"
  # insert the 8 required variables here
 broker_name = "tf-rmq-nonprod"
 host_instance_type = "mq.t3.micro"
 username = "admin"
 password = "P@ssw0rd"
 security_groups = 
 subnet_ids = 


}