# AWS Infrastructure - Nautilus Project

## Overview
This Terraform configuration creates AWS resources for the Nautilus DevOps team:
1. **Kinesis Data Stream** (`nautilus-stream`) - For real-time data processing
2. **SNS Topic** (`nautilus-notifications`) - For sending notifications

## Prerequisites

Before you begin, ensure you have:

1. **Terraform installed** (version 1.0 or higher)
   ```bash
   terraform --version
   ```

2. **AWS CLI configured** with appropriate credentials
   ```bash
   aws configure
   ```
   You'll need:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region (e.g., us-east-1)

3. **Appropriate AWS IAM permissions** to create:
   - Kinesis streams
   - SNS topics

## Project Structure

```
/home/bob/terraform/
├── main.tf          # Main Terraform configuration file
└── README.md        # This file
```

## Resources Created

### 1. Kinesis Data Stream
- **Name**: `nautilus-stream`
- **Shard Count**: 1
- **Retention Period**: 24 hours
- **Stream Mode**: PROVISIONED
- **Metrics**: IncomingBytes, IncomingRecords, OutgoingBytes, OutgoingRecords

### 2. SNS Topic
- **Name**: `nautilus-notifications`
- **Purpose**: Send notifications to subscribers
- **Protocols Supported**: Email, SMS, HTTP/HTTPS, Lambda, SQS, etc.

## Deployment Steps

### 1. Navigate to the Terraform Directory

```bash
cd /home/bob/terraform
```

Or in VS Code:
- Right-click under the EXPLORER section
- Select "Open in Integrated Terminal"

### 2. Initialize Terraform

```bash
terraform init
```

This command:
- Downloads the AWS provider plugin
- Initializes the backend
- Prepares the working directory

### 3. Validate Configuration

```bash
terraform validate
```

Ensures the configuration syntax is correct.

### 4. Review Execution Plan

```bash
terraform plan
```

This shows what resources will be created:
- 1 Kinesis stream
- 1 SNS topic

### 5. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the creation.

### 6. Verify Deployment

After successful application, check the outputs:

```bash
terraform output
```

You should see outputs for both Kinesis and SNS resources.

## Verification

### Verify SNS Topic

**Via AWS Console:**
1. Go to AWS Console → SNS → Topics
2. Look for `nautilus-notifications`

**Via AWS CLI:**
```bash
aws sns list-topics | grep nautilus-notifications
```

**Via Terraform:**
```bash
terraform show | grep sns_topic
```

### Verify Kinesis Stream

**Via AWS Console:**
1. Go to AWS Console → Kinesis → Data Streams
2. Look for `nautilus-stream`

**Via AWS CLI:**
```bash
aws kinesis describe-stream --stream-name nautilus-stream
```

### Confirm No Changes Needed

```bash
terraform plan
```

Should return:
```
No changes. Your infrastructure matches the configuration.
```

## SNS Topic Usage

### Subscribe to the Topic

#### Email Subscription
```bash
aws sns subscribe \
  --topic-arn $(terraform output -raw sns_topic_arn) \
  --protocol email \
  --notification-endpoint your-email@example.com
```

**Note**: You'll receive a confirmation email. Click the link to confirm.

#### SMS Subscription
```bash
aws sns subscribe \
  --topic-arn $(terraform output -raw sns_topic_arn) \
  --protocol sms \
  --notification-endpoint +1234567890
```

#### Lambda Function Subscription
```bash
aws sns subscribe \
  --topic-arn $(terraform output -raw sns_topic_arn) \
  --protocol lambda \
  --notification-endpoint arn:aws:lambda:region:account:function:function-name
```

### Publish a Test Message

```bash
aws sns publish \
  --topic-arn $(terraform output -raw sns_topic_arn) \
  --message "Test notification from Nautilus team" \
  --subject "Test Alert"
```

### Using Python to Publish Messages

```python
import boto3
import json

sns = boto3.client('sns', region_name='us-east-1')

# Get the topic ARN
topic_arn = 'arn:aws:sns:us-east-1:ACCOUNT_ID:nautilus-notifications'

# Publish a simple message
response = sns.publish(
    TopicArn=topic_arn,
    Message='Alert: System status update',
    Subject='Nautilus Notification'
)

print(f"Message ID: {response['MessageId']}")
```

### Publishing Structured Messages

```python
import boto3
import json

sns = boto3.client('sns', region_name='us-east-1')

message = {
    'default': 'Default message',
    'email': 'Email-specific message with details',
    'sms': 'Short SMS message'
}

response = sns.publish(
    TopicArn='arn:aws:sns:us-east-1:ACCOUNT_ID:nautilus-notifications',
    Message=json.dumps(message),
    Subject='Multi-protocol Notification',
    MessageStructure='json'
)
```

## Kinesis Stream Usage

### Writing to the Stream

```python
import boto3
import json

kinesis = boto3.client('kinesis', region_name='us-east-1')

data = {'event': 'user_action', 'timestamp': '2025-01-18T10:00:00Z'}

response = kinesis.put_record(
    StreamName='nautilus-stream',
    Data=json.dumps(data),
    PartitionKey='partition_key'
)

print(f"Record added to shard: {response['ShardId']}")
```

### Reading from the Stream

```python
import boto3

kinesis = boto3.client('kinesis', region_name='us-east-1')

response = kinesis.get_shard_iterator(
    StreamName='nautilus-stream',
    ShardId='shardId-000000000000',
    ShardIteratorType='LATEST'
)

shard_iterator = response['ShardIterator']

while True:
    response = kinesis.get_records(ShardIterator=shard_iterator)
    records = response['Records']
    
    for record in records:
        print(record['Data'])
    
    shard_iterator = response['NextShardIterator']
```

## Integration: Kinesis + SNS

### Use Case: Send SNS Notification on Stream Events

You can trigger SNS notifications based on Kinesis stream activity using Lambda:

```python
import boto3
import json

def lambda_handler(event, context):
    sns = boto3.client('sns')
    
    for record in event['Records']:
        # Decode Kinesis data
        payload = json.loads(record['kinesis']['data'])
        
        # Send SNS notification
        sns.publish(
            TopicArn='arn:aws:sns:us-east-1:ACCOUNT_ID:nautilus-notifications',
            Message=f"Kinesis event processed: {payload}",
            Subject='Kinesis Stream Alert'
        )
    
    return {'statusCode': 200}
```

## Monitoring

### SNS Metrics (CloudWatch)

Monitor these metrics:
- `NumberOfMessagesPublished`: Messages sent to topic
- `NumberOfNotificationsDelivered`: Successful deliveries
- `NumberOfNotificationsFailed`: Failed deliveries

### Kinesis Metrics (CloudWatch)

Monitor these metrics:
- `IncomingRecords`: Records written to stream
- `IncomingBytes`: Data volume
- `GetRecords.Success`: Successful reads
- `IteratorAgeMilliseconds`: Processing lag

### Create CloudWatch Alarms

```bash
# SNS alarm for failed notifications
aws cloudwatch put-metric-alarm \
  --alarm-name nautilus-sns-failed-notifications \
  --alarm-description "Alert on SNS delivery failures" \
  --metric-name NumberOfNotificationsFailed \
  --namespace AWS/SNS \
  --statistic Sum \
  --period 300 \
  --threshold 5 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 1

# Kinesis alarm for high iterator age
aws cloudwatch put-metric-alarm \
  --alarm-name nautilus-stream-high-iterator-age \
  --alarm-description "Alert when iterator age is too high" \
  --metric-name IteratorAgeMilliseconds \
  --namespace AWS/Kinesis \
  --statistic Average \
  --period 300 \
  --threshold 60000 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2
```

## Cost Considerations

### SNS Pricing
- **First 1,000 email notifications**: Free
- **Beyond 1,000**: $2.00 per 100,000 emails
- **SMS**: Varies by country ($0.00645 per SMS in US)
- **HTTP/HTTPS**: $0.60 per 1 million notifications

### Kinesis Pricing
- **Shard Hours**: $0.015 per shard hour
- **PUT Payload Units**: $0.014 per million units
- **Monthly estimate** (1 shard): ~$11/month

## Security Best Practices

### SNS Topic Access Policy

Add access policy to control who can publish:

```hcl
resource "aws_sns_topic_policy" "nautilus_notifications_policy" {
  arn = aws_sns_topic.nautilus_notifications.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowPublishFromKinesis"
        Effect = "Allow"
        Principal = {
          Service = "kinesis.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.nautilus_notifications.arn
      }
    ]
  })
}
```

### Enable Encryption

For sensitive data, enable encryption:

```hcl
resource "aws_sns_topic" "nautilus_notifications" {
  name              = "nautilus-notifications"
  kms_master_key_id = "alias/aws/sns"  # Use AWS managed key
}
```

## Troubleshooting

### Issue: SNS subscription not confirmed

**Solution**: Check your email/SMS for confirmation link and click it.

### Issue: Messages not being delivered

**Solution**: 
1. Verify subscription is confirmed
2. Check CloudWatch logs for delivery failures
3. Verify topic ARN is correct

### Issue: "No changes" not showing after apply

**Solution**: Run `terraform plan` again after `terraform apply` completes.

### Issue: Permission denied errors

**Solution**: Ensure IAM user/role has:
- `sns:CreateTopic`
- `sns:Subscribe`
- `sns:Publish`
- `kinesis:CreateStream`
- `kinesis:DescribeStream`

### Issue: Resources already exist

**Solution**: Import existing resources:
```bash
terraform import aws_sns_topic.nautilus_notifications arn:aws:sns:region:account:nautilus-notifications
terraform import aws_kinesis_stream.nautilus_stream nautilus-stream
```

## Common Use Cases

### 1. Application Alerts
Send notifications when application errors occur or thresholds are breached.

### 2. System Monitoring
Notify team members of system health issues or performance degradation.

### 3. Workflow Notifications
Notify users when data processing jobs complete or fail.

### 4. Real-time Analytics Pipeline
Ingest data via Kinesis, process it, and send summaries via SNS.

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

Type `yes` when prompted.

**Warning**: This will permanently delete:
- The SNS topic (all subscriptions will be deleted)
- The Kinesis stream (all data will be lost)

## Additional Resources

- [AWS SNS Documentation](https://docs.aws.amazon.com/sns/)
- [AWS Kinesis Documentation](https://docs.aws.amazon.com/kinesis/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [SNS Best Practices](https://docs.aws.amazon.com/sns/latest/dg/sns-best-practices.html)

## Support

For issues or questions:
- **Team**: Nautilus DevOps Team
- **AWS Documentation**: SNS and Kinesis guides
- **Terraform Registry**: hashicorp/aws provider docs

---

**Last Updated**: January 2025  
**Maintained By**: Nautilus DevOps Team  
**Terraform Version**: >= 1.0  
**AWS Provider Version**: ~> 5.0
