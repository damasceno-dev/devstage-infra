output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.s3.bucket
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.s3.arn
}

output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.s3.id
}

output "s3_bucket_policy" {
  description = "The policy attached to the S3 bucket"
  value       = aws_s3_bucket_policy.s3_policy.policy
}

output "s3_bucket_versioning_status" {
  description = "The versioning status of the S3 bucket"
  value       = aws_s3_bucket_versioning.s3_versioning.versioning_configuration[0].status
}
