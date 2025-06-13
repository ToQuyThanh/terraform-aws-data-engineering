# Alerting outputs

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.name
}

output "sns_topic_id" {
  description = "ID of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.id
}

output "email_subscription_arns" {
  description = "ARNs of email subscriptions"
  value       = aws_sns_topic_subscription.email_alerts[*].arn
}

output "sms_subscription_arns" {
  description = "ARNs of SMS subscriptions"
  value       = aws_sns_topic_subscription.sms_alerts[*].arn
}

output "slack_lambda_function_arn" {
  description = "ARN of the Slack notifier Lambda function"
  value       = var.enable_slack_notifications ? aws_lambda_function.slack_notifier[0].arn : null
}

output "slack_lambda_function_name" {
  description = "Name of the Slack notifier Lambda function"
  value       = var.enable_slack_notifications ? aws_lambda_function.slack_notifier[0].function_name : null
}

