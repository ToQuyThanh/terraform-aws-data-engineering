resource "aws_kinesis_stream" "data_stream" {
  name             = "${var.project_name}-${var.environment}-data-stream"
  shard_count      = var.kinesis_shard_count
  retention_period = var.kinesis_retention_period
  tags             = var.tags
}

output "kinesis_stream_arn" {
  value = aws_kinesis_stream.data_stream.arn
}

output "data_stream_name" {
  value = aws_kinesis_stream.data_stream.name
}
