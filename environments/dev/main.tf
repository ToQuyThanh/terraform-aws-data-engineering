module "provider" {
  source               = "../../shared/provider"
  aws_region           = "ap-southeast-1"
   additional_tags = {
    Environment = "dev"
    Owner       = "data-team"
  }
}

# Import shared configurations
module "shared_tagging" {
  source = "../../shared/tagging"

  project_name = var.project_name
  environment  = var.environment
  cost_center  = var.cost_center
  owner        = var.owner
}

module "shared_alerting" {
  source = "../../shared/alerting"
  
  project_name           = var.project_name
  environment           = var.environment
  alert_email_endpoints = var.alert_email_endpoints
  alert_phone_endpoints = var.alert_phone_endpoints
  tags                  = module.shared_tagging.common_tags
}

# Core infrastructure modules
module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  tags         = module.shared_tagging.common_tags
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

