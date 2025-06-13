variable "kinesis_stream_name" {
  description = "Name of the Kinesis stream to monitor"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}