resource "aws_athena_workgroup" "main" {
  name = "${var.project_name}-${var.environment}-workgroup"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true
    bytes_scanned_cutoff_per_query     = 10000000000
    requester_pays_enabled             = false

    result_configuration {
      output_location = "s3://${var.athena_results_bucket_name}/"
      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
  tags = var.tags
}

output "athena_workgroup_name" {
  value = aws_athena_workgroup.main.name
}


