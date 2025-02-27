# the prefix is coming from the previous step
# variable "prefix" {
#   description = "Prefix for resource names"
#   type        = string
#   default     = data.terraform_remote_state.resources.outputs.prefix
# }

# for github actions or act (ci), its going to take the profile from the aws_id used in the credentials step. 
# Use this if you want to run locally and have aws profiles configured in your machine 
# variable "user_profile" {
#   description = "AWS profile that received permission to create the resources from the admin template and now is going to create the resources"
#   type        = string
# }