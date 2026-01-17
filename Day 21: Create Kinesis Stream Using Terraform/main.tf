resource "aws_kinesis_stream" "nautilus_stream" {
  name             = "nautilus-stream"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "IncomingRecords",
    "OutgoingBytes",
    "OutgoingRecords",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = {
    Name        = "nautilus-stream"
    Environment = "production"
    ManagedBy   = "Terraform"
    Purpose     = "real-time-data-processing"
  }
}

output "stream_name" {
  description = "The name of the Kinesis stream"
  value       = aws_kinesis_stream.nautilus_stream.name
}

output "stream_arn" {
  description = "The ARN of the Kinesis stream"
  value       = aws_kinesis_stream.nautilus_stream.arn
}

output "stream_id" {
  description = "The unique identifier of the Kinesis stream"
  value       = aws_kinesis_stream.nautilus_stream.id
}
