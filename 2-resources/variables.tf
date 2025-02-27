variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "db_password" {
  description = "The database password. Make sure to enter the same password from your Infrastructure.env file."
  type        = string
  sensitive   = true
}

# the prefix is coming from the previous step
# variable "prefix" {
#   description = "Prefix for resource names"
#   type        = string
# }

# for github actions or act (ci), its going to take the profile from the aws_id used in the credentials step. 
# Use this if you want to run locally and have aws profiles configured in your machine 
# variable "resource_creator_profile" {
#   description = "AWS profile that received permission to create the resources from the admin template and now is going to create the resources"
#   type        = string
#   default     = var.resources_creator_profile
# }