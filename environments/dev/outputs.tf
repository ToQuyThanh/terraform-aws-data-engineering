# Dev Environment Outputs

# Infrastructure outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.networking.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.networking.private_subnet_ids
}

# Security outputs
output "data_ingestion_security_group_id" {
  description = "ID of data ingestion security group"
  value       = module.networking.data_ingestion_security_group_id
}

output "processing_security_group_id" {
  description = "ID of processing security group"
  value       = module.networking.processing_security_group_id
}

# Data platform outputs
output "kinesis_stream_arn" {
  description = "ARN of the Kinesis data stream"
  value       = module.data_ingestion.kinesis_stream_arn
}

output "kinesis_stream_name" {
  description = "Name of the Kinesis data stream"
  value       = module.data_ingestion.data_stream_name
}

output "raw_data_bucket_name" {
  description = "Name of the raw data S3 bucket"
  value       = module.data_storage.raw_data_bucket_name
}

output "processed_data_bucket_name" {
  description = "Name of the processed data S3 bucket"
  value       = module.data_storage.processed_data_bucket_name
}

# Analytics outputs
output "athena_workgroup_name" {
  description = "Name of the Athena workgroup"
  value       = module.data_analytics.athena_workgroup_name
}

output "glue_catalog_database_name" {
  description = "Name of the Glue catalog database"
  value       = module.data_processing.glue_catalog_database_name
}

# Alerting outputs
output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = module.shared_alerting.sns_topic_arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for alerts"
  value       = module.shared_alerting.sns_topic_name
}

# Tagging outputs
output "common_tags" {
  description = "Common tags applied to resources"
  value       = module.shared_tagging.common_tags
}

output "resource_prefix" {
  description = "Resource naming prefix"
  value       = module.shared_tagging.resource_prefix
}

