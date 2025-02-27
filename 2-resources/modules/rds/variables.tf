variable "prefix" {}
variable "vpc_id" {}
variable "subnet_ids" {}

variable "db_name" {}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {}