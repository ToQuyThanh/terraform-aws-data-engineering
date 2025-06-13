
variable "kinesis_shard_count" {
  description = "Number of shards for Kinesis stream"
  type        = number
  default     = 1
}

variable "kinesis_retention_period" {
  description = "Retention period for Kinesis stream in hours"
  type        = number
  default     = 24
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "data-platform"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}
