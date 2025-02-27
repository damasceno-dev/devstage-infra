output "ecr_repository_name" {
  value       = module.ecr.repository_name
  description = "Name of the ECR repository"
}
output "ecr_repository_arn" {
  value       = module.ecr.repository_arn
  description = "ARN of the ECR repository"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "URL of the ECR repository"
}

output "rds_endpoint" {
  value       = module.rds.rds_endpoint
  description = "The RDS endpoint for database connection"
}
# 
# output "s3_bucket_name" {
#   description = "The name of the S3 bucket"
#   value       = module.s3.s3_bucket_name
# }
# 
# output "sqs_queue_url" {
#   description = "The URL of the dead-letter queue"
#   value       = module.sqs.sqs_queue_url
# }