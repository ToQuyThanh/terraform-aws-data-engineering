# Common variables used across modules

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "data-platform"

  validation {
    condition     = length(var.project_name) > 0 && length(var.project_name) <= 50
    error_message = "Project name must be between 1 and 50 characters."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "AWS region must be in the format like 'us-east-1' or 'ap-southeast-1'."
  }
}

variable "cost_center" {
  description = "Cost center for billing purposes"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = ""
}

variable "backup_schedule" {
  description = "Backup schedule for automated backups"
  type        = string
  default     = "daily"

  validation {
    condition     = contains(["none", "daily", "weekly", "monthly"], var.backup_schedule)
    error_message = "Backup schedule must be one of: none, daily, weekly, monthly."
  }
}

