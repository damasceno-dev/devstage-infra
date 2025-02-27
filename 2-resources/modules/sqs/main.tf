resource "aws_sqs_queue" "main" {
  name                      = "${var.prefix}-delete-user-account-queue"
  delay_seconds             = var.delay_seconds
  message_retention_seconds = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })
}

resource "aws_sqs_queue" "dlq" {
  name                      = "${var.prefix}-delete-user-account-dlq"
  message_retention_seconds = var.dlq_message_retention_seconds
}
