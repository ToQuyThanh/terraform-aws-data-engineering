# Production Environment Variables

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
  default     = "prod"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "cost_center" {
  description = "Cost center for billing purposes"
  type        = string
  default     = "engineering"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "data-team"
}
