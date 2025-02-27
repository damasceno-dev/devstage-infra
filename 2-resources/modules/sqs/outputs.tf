output "sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.main.id
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "dlq_queue_url" {
  description = "The URL of the dead-letter queue"
  value       = aws_sqs_queue.dlq.id
}

output "dlq_queue_arn" {
  description = "The ARN of the dead-letter queue"
  value       = aws_sqs_queue.dlq.arn
}

