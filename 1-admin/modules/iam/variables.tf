variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}
variable "resources_creator_profile" {
  description = "AWS profile to receive permissions to create the resources from this iam module"
  type        = string
}