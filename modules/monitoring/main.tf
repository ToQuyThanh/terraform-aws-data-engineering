resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.project_name}-${var.environment}-kinesis-processor"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "kinesis_stream_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-kinesis-stream-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ReadProvisionedThroughputExceeded"
  namespace           = "AWS/Kinesis"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alarm when Kinesis stream read throughput is exceeded"
  dimensions = {
    StreamName = var.kinesis_stream_name
  }

  actions_enabled = true
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]


  tags = var.tags
}


