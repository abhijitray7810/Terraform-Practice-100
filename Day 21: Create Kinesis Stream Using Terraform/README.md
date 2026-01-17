# AWS Kinesis Data Stream - Nautilus Project

## Overview
This Terraform configuration creates an AWS Kinesis Data Stream named `nautilus-stream` for real-time data processing. The stream is designed to ingest and process large volumes of streaming data for analytics and real-time decision-making.

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

3. **Appropriate AWS IAM permissions** to create Kinesis streams

## Project Structure

```
/home/bob/terraform/
├── main.tf          # Main Terraform configuration file
└── README.md        # This file
```

## Configuration Details

### Kinesis Stream Specifications

- **Stream Name**: `nautilus-stream`
- **Shard Count**: 1 (can be scaled based on throughput requirements)
- **Retention Period**: 24 hours
- **Stream Mode**: PROVISIONED
- **Region**: us-east-1 (configurable in provider block)

### Shard Level Metrics Enabled

The stream monitors the following metrics:
- IncomingBytes
- IncomingRecords
- OutgoingBytes
- OutgoingRecords

These metrics are available in AWS CloudWatch for monitoring stream performance.

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

This shows what resources will be created without actually creating them.

### 5. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the creation.

### 6. Verify Deployment

After successful application, check the output:

```bash
terraform output
```

You should see:
- `stream_name`: nautilus-stream
- `stream_arn`: The ARN of the created stream
- `stream_id`: The unique identifier

## Verification

### Verify in AWS Console

1. Go to AWS Console → Kinesis → Data Streams
2. Look for `nautilus-stream`
3. Verify the configuration matches

### Verify via AWS CLI

```bash
aws kinesis describe-stream --stream-name nautilus-stream
```

### Check Terraform State

```bash
terraform show
```

Ensure `terraform plan` returns:
```
No changes. Your infrastructure matches the configuration.
```

## Stream Capacity

### Current Configuration
- **1 shard** supports:
  - Write: 1 MB/sec or 1,000 records/sec
  - Read: 2 MB/sec

### Scaling Considerations

If you need higher throughput, increase the `shard_count`:

```hcl
shard_count = 2  # Doubles the capacity
```

Then run:
```bash
terraform apply
```

## Data Retention

The stream retains data for **24 hours** by default. To increase retention:

```hcl
retention_period = 168  # 7 days (maximum)
```

## Cost Considerations

AWS Kinesis charges are based on:
- **Shard Hours**: $0.015 per shard hour
- **PUT Payload Units**: $0.014 per million units (25KB chunks)
- **Extended Data Retention**: Additional charges if > 24 hours

**Monthly cost estimate** (1 shard, 24hr retention): ~$11/month

## Consuming the Stream

### Example: Reading from Stream (Python)

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

### Example: Writing to Stream (Python)

```python
import boto3
import json

kinesis = boto3.client('kinesis', region_name='us-east-1')

data = {'event': 'user_action', 'timestamp': '2025-01-17T10:00:00Z'}

response = kinesis.put_record(
    StreamName='nautilus-stream',
    Data=json.dumps(data),
    PartitionKey='partition_key'
)

print(f"Record added to shard: {response['ShardId']}")
```

## Monitoring

### CloudWatch Metrics

Access metrics in AWS CloudWatch:
- Navigate to CloudWatch → Metrics → Kinesis
- Select `nautilus-stream`

Key metrics to monitor:
- `IncomingRecords`: Records written to stream
- `IncomingBytes`: Data volume written
- `GetRecords.Success`: Successful read operations
- `IteratorAgeMilliseconds`: Processing lag

### Set Up Alarms

```bash
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

## Cleanup

To destroy the Kinesis stream and all associated resources:

```bash
terraform destroy
```

Type `yes` when prompted.

**Warning**: This will permanently delete the stream and any data in it.

## Troubleshooting

### Issue: "No changes" not showing after apply

**Solution**: Run `terraform plan` again. If resources are already created, it should show no changes.

### Issue: AWS credentials not configured

**Solution**:
```bash
aws configure
```

### Issue: Insufficient permissions

**Solution**: Ensure your IAM user/role has these permissions:
- `kinesis:CreateStream`
- `kinesis:DescribeStream`
- `kinesis:DeleteStream`
- `kinesis:AddTagsToStream`

### Issue: Stream already exists

**Solution**: Import existing stream into Terraform state:
```bash
terraform import aws_kinesis_stream.nautilus_stream nautilus-stream
```

## Best Practices

1. **Enable CloudWatch Logging**: Monitor stream health and performance
2. **Use Auto Scaling**: For production, consider using on-demand mode or auto-scaling
3. **Implement Error Handling**: In your consumer applications
4. **Monitor Iterator Age**: Ensure consumers keep up with producers
5. **Tag Resources**: For cost tracking and organization
6. **Use Encryption**: Enable server-side encryption for sensitive data

## Additional Resources

- [AWS Kinesis Documentation](https://docs.aws.amazon.com/kinesis/)
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Kinesis Best Practices](https://docs.aws.amazon.com/streams/latest/dev/best-practices.html)

## Support

For issues or questions:
- Contact: Nautilus DevOps Team
- Documentation: AWS Kinesis Data Streams Guide
- Terraform Registry: hashicorp/aws provider documentation

---

**Last Updated**: January 2025  
**Maintained By**: Nautilus DevOps Team  
**Terraform Version**: >= 1.0  
**AWS Provider Version**: ~> 5.0
