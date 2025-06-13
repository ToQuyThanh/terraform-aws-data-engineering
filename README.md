# terraform-aws-data-engineering
This project presents a Modern Data Platform built on AWS Cloud, capable of handling both batch and near real-time data processing.


---
## Project structure

```
├── environments/           # Environment-specific configurations
│   ├── dev/
│   ├── staging/
│   └── prod/
├── modules/               # Core business logic modules
│   ├── data-analytics/
│   ├── data-ingestion/
│   ├── data-processing/
│   ├── data-storage/
│   ├── monitoring/
│   ├── networking/
│   └── security/
├── shared/               # Shared/reusable modules
│   ├── alerting/
│   ├── backend/
│   ├── common/
│   ├── provider/
│   └── tagging/
├── scripts/              # Automation scripts
│   ├── deploy.sh
│   ├── migrate.sh
│   └── validate.sh
└── docs/                # Documentation
```


---
## Prerequisites

### 1. Required Tools

- **Terraform**: >= 1.0  
- **AWS CLI**: >= 2.0  
- **Bash**: >= 4.0 (for scripts)

### 2. AWS Credentials

Make sure your AWS credentials are properly configured:

```bash
aws configure
# or
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="ap-southeast-1"
```

### 3. Terraform Backend Setup

Before deploying, you need to create S3 buckets and DynamoDB tables for Terraform backend:

```bash
# Create S3 buckets for storing Terraform state
aws s3 mb s3://data-platform-dev-terraform-state --region ap-southeast-1
aws s3 mb s3://data-platform-staging-terraform-state --region ap-southeast-1
aws s3 mb s3://data-platform-prod-terraform-state --region ap-southeast-1

# Create DynamoDB tables for state locking
aws dynamodb create-table \
    --table-name data-platform-dev-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region ap-southeast-1

aws dynamodb create-table \
    --table-name data-platform-staging-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region ap-southeast-1

aws dynamodb create-table \
    --table-name data-platform-prod-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region ap-southeast-1
```