#Export vars from tf-cloud var
variable "access_key" {}
variable "secret_key" {}

variable "env" {
  type    = string
  default = "dev"
}
