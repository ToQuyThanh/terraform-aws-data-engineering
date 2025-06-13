# Alerting infrastructure

locals {
  topic_name = "${var.project_name}-${var.environment}-alerts"
}

# SNS topic for alerts
resource "aws_sns_topic" "alerts" {
  name = local.topic_name

  tags = merge(var.tags, {
    Name    = local.topic_name
    Purpose = "Alert notifications"
  })
}

# SNS topic policy
resource "aws_sns_topic_policy" "alerts" {
  arn = aws_sns_topic.alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "cloudwatch.amazonaws.com",
            "lambda.amazonaws.com",
            "events.amazonaws.com"
          ]
        }
        Action = [
          "SNS:Publish"
        ]
        Resource = aws_sns_topic.alerts.arn
      }
    ]
  })
}

# Email subscriptions
resource "aws_sns_topic_subscription" "email_alerts" {
  count     = length(var.alert_email_endpoints)
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email_endpoints[count.index]
}

# SMS subscriptions
resource "aws_sns_topic_subscription" "sms_alerts" {
  count     = length(var.alert_phone_endpoints)
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "sms"
  endpoint  = var.alert_phone_endpoints[count.index]
}

# Lambda function for Slack notifications (if enabled)
resource "aws_lambda_function" "slack_notifier" {
  count = var.enable_slack_notifications ? 1 : 0

  filename      = "slack_notifier.zip"
  function_name = "${var.project_name}-${var.environment}-slack-notifier"
  role          = aws_iam_role.lambda_role[0].arn
  handler       = "index.handler"
  runtime       = "python3.9"
  timeout       = 30

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
    }
  }

  tags = merge(var.tags, {
    Name    = "${var.project_name}-${var.environment}-slack-notifier"
    Purpose = "Slack alert notifications"
  })
}

# IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  count = var.enable_slack_notifications ? 1 : 0

  name = "${var.project_name}-${var.environment}-slack-notifier-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Name    = "${var.project_name}-${var.environment}-slack-notifier-role"
    Purpose = "Lambda execution role for Slack notifications"
  })
}

# IAM policy attachment for Lambda basic execution
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  count      = var.enable_slack_notifications ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role[0].name
}

# SNS subscription for Lambda
resource "aws_sns_topic_subscription" "slack_alerts" {
  count     = var.enable_slack_notifications ? 1 : 0
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.slack_notifier[0].arn
}

# Lambda permission for SNS
resource "aws_lambda_permission" "sns_invoke" {
  count         = var.enable_slack_notifications ? 1 : 0
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_notifier[0].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.alerts.arn
}

