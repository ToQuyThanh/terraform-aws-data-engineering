# Dev Environment Variables

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
  default     = "dev"

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

variable "alert_email_endpoints" {
  description = "List of email endpoints for alerts"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for email in var.alert_email_endpoints : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))
    ])
    error_message = "All email endpoints must be valid email addresses."
  }
}

variable "alert_phone_endpoints" {
  description = "List of phone numbers for SMS alerts"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

module "security" {
  source = "../../modules/security"

  project_name   = var.project_name
  environment    = var.environment
  s3_bucket_name = module.data_storage.raw_data_bucket_name
  tags           = module.shared_tagging.common_tags
}

module "data_storage" {
  source = "../../modules/data-storage"

  project_name = var.project_name
  environment  = var.environment
  tags         = module.shared_tagging.common_tags
}

module "data_ingestion" {
  source = "../../modules/data-ingestion"

  project_name = var.project_name
  environment  = var.environment
  tags         = module.shared_tagging.common_tags
}

module "data_processing" {
  source = "../../modules/data-processing"

  project_name                 = var.project_name
  environment                  = var.environment
  lambda_execution_role_arn    = module.security.kinesis_service_role_arn
  processed_data_bucket_name   = module.data_storage.processed_data_bucket_name
  private_subnet_ids           = module.networking.private_subnet_ids
  processing_security_group_id = module.networking.processing_security_group_id
  kinesis_stream_arn           = module.data_ingestion.kinesis_stream_arn
  tags                         = module.shared_tagging.common_tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name        = var.project_name
  environment         = var.environment
  kinesis_stream_name = module.data_ingestion.data_stream_name
  sns_topic_arn       = module.shared_alerting.sns_topic_arn
  tags                = module.shared_tagging.common_tags
}

module "data_analytics" {
  source = "../../modules/data-analytics"

  project_name               = var.project_name
  environment                = var.environment
  athena_results_bucket_name = module.data_storage.processed_data_bucket_name
  tags                       = module.shared_tagging.common_tags
}

