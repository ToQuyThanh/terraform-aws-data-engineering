# Tagging and naming conventions

locals {
  # Common tags applied to all resources
  common_tags = merge({
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    CreatedAt   = formatdate("YYYY-MM-DD", timestamp())
    },
    var.cost_center != "" ? { CostCenter = var.cost_center } : {},
    var.owner != "" ? { Owner = var.owner } : {},
    var.backup_schedule != "" ? { BackupSchedule = var.backup_schedule } : {},
    var.additional_tags
  )

  # Standard resource naming prefix
  resource_prefix = "${var.project_name}-${var.environment}"

  # Naming conventions for different resource types
  naming_conventions = {
    # Storage
    s3_bucket      = "${local.resource_prefix}-{purpose}"
    dynamodb_table = "${local.resource_prefix}-{purpose}"

    # Compute
    lambda_function = "${local.resource_prefix}-{purpose}"
    ecs_cluster     = "${local.resource_prefix}-{purpose}"

    # Networking
    vpc              = "${local.resource_prefix}-vpc"
    subnet           = "${local.resource_prefix}-{type}-subnet-{az}"
    security_group   = "${local.resource_prefix}-{purpose}-sg"
    internet_gateway = "${local.resource_prefix}-igw"
    nat_gateway      = "${local.resource_prefix}-nat-{az}"

    # Data services
    kinesis_stream   = "${local.resource_prefix}-{purpose}-stream"
    glue_job         = "${local.resource_prefix}-{purpose}-job"
    athena_workgroup = "${local.resource_prefix}-{purpose}-workgroup"

    # Monitoring
    cloudwatch_log_group = "/aws/{service}/${local.resource_prefix}-{purpose}"
    sns_topic            = "${local.resource_prefix}-{purpose}"

    # Security
    iam_role   = "${local.resource_prefix}-{purpose}-role"
    iam_policy = "${local.resource_prefix}-{purpose}-policy"
    kms_key    = "${local.resource_prefix}-{purpose}-key"
  }
}

