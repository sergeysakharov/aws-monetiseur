#Export vars from tf-cloud var
variable "access_key" {}
variable "secret_key" {}

variable "envnonprod" {
  type    = string
  default = "nonprod"
}

variable "project" {
  type    = string
  default = "monetiseur"
}