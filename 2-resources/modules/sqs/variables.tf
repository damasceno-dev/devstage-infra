variable "prefix" {}
variable "delay_seconds" {
  description = "Delay in seconds for the queue"
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "Retention period for messages in seconds"
  type        = number
  default     = 345600 # 4 days
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds"
  type        = number
  default     = 30
}

variable "receive_wait_time_seconds" {
  description = "Wait time for long polling"
  type        = number
  default     = 10
}

variable "max_receive_count" {
  description = "Max number of times a message can be received before sending to DLQ"
  type        = number
  default     = 5
}

variable "dlq_message_retention_seconds" {
  description = "Retention period for messages in the dead-letter queue"
  type        = number
  default     = 1209600 # 14 days
}
