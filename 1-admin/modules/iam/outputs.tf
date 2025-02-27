output "iam_user_policies" {
  description = "List of IAM policies attached to the user."
  value = {
    VPC         = aws_iam_policy.vpc_policy.arn
    S3          = aws_iam_policy.s3_policy.arn
    SQS         = aws_iam_policy.sqs_policy.arn
    RDS         = aws_iam_policy.rds_policy.arn
    ECR         = aws_iam_policy.ecr_policy.arn
    App_Runner  = aws_iam_policy.app_runner_policy.arn
  }
}
output "iam_user_profile" {
  description = "The IAM user profile receiving these policies."
  value       = var.resources_creator_profile
}