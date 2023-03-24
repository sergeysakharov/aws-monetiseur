#Export vars from tf-cloud var
variable "access_key" {}
variable "secret_key" {}
variable "pgsql-nonprod-password" {}


variable "envnonprod" {
  type    = string
  default = "nonprod"
}

variable "envprod" {
  type    = string
  default = "prod"
}

variable "project" {
  type    = string
  default = "monetiseur"
}