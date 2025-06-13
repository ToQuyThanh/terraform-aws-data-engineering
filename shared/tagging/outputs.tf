# Tagging outputs

output "common_tags" {
  description = "Common tags to apply to all resources"
  value       = local.common_tags
}

output "resource_prefix" {
  description = "Standard resource naming prefix"
  value       = local.resource_prefix
}

output "naming_conventions" {
  description = "Naming conventions for different resource types"
  value       = local.naming_conventions
}

# Helper functions for generating resource names
output "s3_bucket_name" {
  description = "Function to generate S3 bucket names"
  value       = local.naming_conventions.s3_bucket
}

output "lambda_function_name" {
  description = "Function to generate Lambda function names"
  value       = local.naming_conventions.lambda_function
}

output "security_group_name" {
  description = "Function to generate security group names"
  value       = local.naming_conventions.security_group
}

output "iam_role_name" {
  description = "Function to generate IAM role names"
  value       = local.naming_conventions.iam_role
}

