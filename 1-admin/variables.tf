variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}
# for github actions or act (ci), its going to take the profile from the aws_id used in the credentials step. 
# Use this if you want to run locally and have aws profiles configured in your machine 
# variable "admin_profile" {
#   description = "AWS profile to give permissions to create the resources from this iam module"
#   type        = string
# }
variable "resources_creator_profile" {
  description = "AWS profile to receive permissions to create the resources from this iam module"
  type        = string
}