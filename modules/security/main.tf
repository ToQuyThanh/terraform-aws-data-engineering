resource "aws_iam_role" "kinesis_service_role" {
  name = "${var.project_name}-${var.environment}-kinesis-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "kinesis.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "kinesis_s3_cloudwatch_policy" {
  name = "${var.project_name}-${var.environment}-kinesis-s3-cloudwatch-policy"
  role = aws_iam_role.kinesis_service_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/*",
          "arn:aws:s3:::${var.s3_bucket_name}"
        ]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}

resource "aws_kms_key" "data_encryption_key" {
  description             = "KMS key for data encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

output "kinesis_service_role_arn" {
  value = aws_iam_role.kinesis_service_role.arn
}

output "data_encryption_key_arn" {
  value = aws_kms_key.data_encryption_key.arn
}


