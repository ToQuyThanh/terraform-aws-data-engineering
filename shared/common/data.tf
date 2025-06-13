# Common data sources

# Current AWS region
data "aws_region" "current" {}

# Current AWS caller identity
data "aws_caller_identity" "current" {}

# Available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Default VPC (if exists)
data "aws_vpc" "default" {
  default = true
}

# AMI for Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Current AWS partition
data "aws_partition" "current" {}

