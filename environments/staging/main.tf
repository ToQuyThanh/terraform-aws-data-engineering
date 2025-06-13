module "provider" {
  source               = "../../shared/provider"
  aws_region           = "ap-southeast-1"
  additional_tags = {
    Environment = "staging"
    Owner       = "data-team"
  }
}
