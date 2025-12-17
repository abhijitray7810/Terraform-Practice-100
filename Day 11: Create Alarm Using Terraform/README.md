# Nautilus CloudWatch Alarm - Terraform Configuration

This repository contains Terraform configuration to create a CloudWatch alarm for monitoring EC2 instance CPU utilization in the Nautilus DevOps environment.

## Overview

The configuration creates a CloudWatch alarm named `nautilus-alarm` that monitors CPU utilization of an EC2 instance and triggers when the CPU exceeds 80% for a 5-minute evaluation period.

## Prerequisites

- Terraform installed (version 1.0 or higher)
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create CloudWatch alarms
- At least one running EC2 instance in your AWS account

## Alarm Specifications

| Parameter | Value | Description |
|-----------|-------|-------------|
| **Alarm Name** | `nautilus-alarm` | Name of the CloudWatch alarm |
| **Metric** | `CPUUtilization` | Monitors CPU usage percentage |
| **Threshold** | `80%` | Alarm triggers when CPU exceeds this value |
| **Evaluation Period** | `5 minutes (300 seconds)` | Time window for evaluation |
| **Number of Periods** | `1` | Single evaluation period required |
| **Statistic** | `Average` | Uses average CPU over the period |
| **Namespace** | `AWS/EC2` | AWS EC2 metrics namespace |

## File Structure

```
/home/bob/terraform/
├── main.tf          # Main Terraform configuration file
└── README.md        # This documentation file
```

## Configuration Details

### CloudWatch Alarm Resource

The alarm is configured with the following settings:

- **Comparison Operator**: `GreaterThanThreshold`
- **Missing Data Treatment**: `notBreaching` (alarm won't trigger on missing data)
- **Alarm Description**: "This metric monitors EC2 CPU utilization"

### Instance Selection

The configuration automatically selects the first running EC2 instance in your account. To monitor a specific instance, modify the `dimensions` block in `main.tf`:

```hcl
dimensions = {
  InstanceId = "i-1234567890abcdef0"  # Replace with your instance ID
}
```

## Usage

### 1. Navigate to the Terraform Directory

```bash
cd /home/bob/terraform
```

### 2. Initialize Terraform

Download required providers and initialize the working directory:

```bash
terraform init
```

### 3. Validate Configuration

Check for syntax errors:

```bash
terraform validate
```

### 4. Review the Execution Plan

Preview the resources that will be created:

```bash
terraform plan
```

### 5. Apply the Configuration

Create the CloudWatch alarm:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 6. Verify Deployment

After successful deployment, Terraform will output:
- Alarm ARN
- Alarm name
- Monitored instance ID

## Customization

### Change AWS Region

Modify the provider configuration in `main.tf`:

```hcl
provider "aws" {
  region = "us-west-2"  # Change to your preferred region
}
```

### Adjust Threshold

To change the CPU threshold percentage:

```hcl
threshold = 90  # Change from 80 to 90%
```

### Modify Evaluation Period

To change the evaluation time window:

```hcl
period = 600  # Change to 10 minutes (in seconds)
```

### Add Multiple Evaluation Periods

To require multiple consecutive breaches:

```hcl
evaluation_periods = 2  # Require 2 consecutive periods above threshold
```

## Monitoring the Alarm

### Via AWS Console

1. Navigate to **CloudWatch** in the AWS Console
2. Click on **Alarms** in the left sidebar
3. Look for `nautilus-alarm`
4. View alarm status, history, and metrics

### Via AWS CLI

```bash
# Describe the alarm
aws cloudwatch describe-alarms --alarm-names nautilus-alarm

# Get alarm history
aws cloudwatch describe-alarm-history --alarm-name nautilus-alarm
```

## Alarm States

| State | Description |
|-------|-------------|
| **OK** | CPU utilization is below 80% |
| **ALARM** | CPU utilization exceeds 80% for 5 minutes |
| **INSUFFICIENT_DATA** | Not enough data to evaluate the alarm |

## Adding Notifications (Optional)

To receive notifications when the alarm triggers, add an SNS topic:

```hcl
# Create SNS topic
resource "aws_sns_topic" "alarm_notifications" {
  name = "nautilus-alarm-notifications"
}

# Subscribe email to topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = "devops@nautilus.com"
}

# Add to alarm
resource "aws_cloudwatch_metric_alarm" "nautilus_alarm" {
  # ... existing configuration ...
  alarm_actions = [aws_sns_topic.alarm_notifications.arn]
}
```

## Cleanup

To remove all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm deletion.

## Troubleshooting

### No Running Instances Found

If you see "No running instances found" in the output:
- Verify you have running EC2 instances in your AWS account
- Check that your AWS credentials have permissions to describe instances
- Manually specify an instance ID in the `dimensions` block

### Permission Denied Errors

Ensure your AWS credentials have the following permissions:
- `cloudwatch:PutMetricAlarm`
- `cloudwatch:DescribeAlarms`
- `ec2:DescribeInstances`

### Alarm Always in INSUFFICIENT_DATA State

- Verify the EC2 instance is running
- Check that detailed monitoring is enabled on the instance (optional, but recommended)
- Wait a few minutes for metrics to populate

## Outputs

The configuration provides the following outputs:

- **alarm_arn**: The Amazon Resource Name of the created alarm
- **alarm_name**: The name of the alarm (nautilus-alarm)
- **monitored_instance_id**: The ID of the EC2 instance being monitored

View outputs after applying:

```bash
terraform output
```

## Best Practices

1. **Enable Detailed Monitoring**: Enable detailed monitoring on EC2 instances for 1-minute metric granularity
2. **Use SNS Notifications**: Configure SNS topics to receive alarm notifications
3. **Document Changes**: Update this README when modifying alarm parameters
4. **Version Control**: Commit Terraform state files to secure storage (not public repositories)
5. **Regular Reviews**: Periodically review alarm thresholds and adjust based on workload patterns

## Additional Resources

- [AWS CloudWatch Alarms Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- [Terraform AWS CloudWatch Alarm Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)
- [EC2 Instance Metrics](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html)

## Support

For issues or questions:
- Contact the Nautilus DevOps team
- Review AWS CloudWatch documentation
- Check Terraform AWS provider documentation

---

**Created by**: Nautilus DevOps Team  
**Last Updated**: December 2025  
**Version**: 1.0
