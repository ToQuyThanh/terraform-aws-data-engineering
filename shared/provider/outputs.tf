# Provider outputs

output "aws_region" {
  description = "Current AWS region"
  value       = data.aws_region.current.name
}

output "aws_account_id" {
  description = "Current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "availability_zones" {
  description = "Available availability zones in the current region"
  value       = data.aws_availability_zones.available.names
}
