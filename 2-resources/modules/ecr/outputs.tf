

output "repository_name" {
  value       = aws_ecr_repository.ecr.name
  description = "Name of the ECR repository"
}
        
output "repository_arn" {
  value       = aws_ecr_repository.ecr.arn
  description = "ARN of the ECR repository"
}

output "repository_url" {
  value       = aws_ecr_repository.ecr.repository_url
  description = "URL of the ECR repository"
}