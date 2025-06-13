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
