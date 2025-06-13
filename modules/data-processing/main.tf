resource "aws_lambda_function" "kinesis_processor" {
  function_name    = "${var.project_name}-${var.environment}-kinesis-processor"
  handler          = "main.handler"
  runtime          = "python3.9"
  role             = var.lambda_execution_role_arn
  filename         = "${path.module}/lambda_function_payload.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_payload.zip")

  environment {
    variables = {
      S3_BUCKET_NAME = var.processed_data_bucket_name
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.processing_security_group_id]
  }

  tags = var.tags
}

resource "aws_lambda_event_source_mapping" "kinesis_event_source" {
  event_source_arn  = var.kinesis_stream_arn
  function_name     = aws_lambda_function.kinesis_processor.arn
  starting_position = "LATEST"
}

resource "aws_glue_catalog_database" "main" {
  name = "${var.project_name}_${var.environment}_db"

  tags = var.tags
}
