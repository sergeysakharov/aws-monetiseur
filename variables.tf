#Export vars from tf-cloud var
variable "access_key" {}
variable "secret_key" {}

variable "env.nonprod" {
  type    = string
  default = "nonprod"
}

variable "project" {
  type    = string
  default = "monetiseur"
}