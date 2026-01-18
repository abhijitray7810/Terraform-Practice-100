resource "aws_sns_topic" "nautilus_notifications" {
  name = "nautilus-notifications"

  tags = {
    Name        = "nautilus-notifications"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

output "topic_name" {
  description = "The name of the SNS topic"
  value       = aws_sns_topic.nautilus_notifications.name
}

output "topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.nautilus_notifications.arn
}
