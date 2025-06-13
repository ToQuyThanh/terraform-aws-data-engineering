module "provider" {
  source               = "../../shared/provider"
  aws_region           = "ap-southeast-1"
  additional_tags = {
    Environment = "prod"
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
