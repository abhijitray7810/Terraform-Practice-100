# Data source to get an existing EC2 instance
# You can modify this to target a specific instance by tag or ID
data "aws_instances" "existing" {
  instance_state_names = ["running"]
}

# CloudWatch Alarm for EC2 CPU Utilization
resource "aws_cloudwatch_metric_alarm" "nautilus_alarm" {
  alarm_name          = "nautilus-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300  # 5 minutes in seconds
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors EC2 CPU utilization"
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = length(data.aws_instances.existing.ids) > 0 ? data.aws_instances.existing.ids[0] : "i-xxxxxxxxxxxxxxxxx"
  }
}

# Output the alarm ARN
output "alarm_arn" {
  description = "The ARN of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.nautilus_alarm.arn
}

output "alarm_name" {
  description = "The name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.nautilus_alarm.alarm_name
}

output "monitored_instance_id" {
  description = "The EC2 instance being monitored"
  value       = length(data.aws_instances.existing.ids) > 0 ? data.aws_instances.existing.ids[0] : "No running instances found"
}
