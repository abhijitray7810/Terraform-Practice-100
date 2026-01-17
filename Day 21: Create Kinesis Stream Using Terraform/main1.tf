resource "aws_kinesis_stream" "xfusion_stream" {
  name        = "xfusion-stream"
  shard_count = 1

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }
}

output "stream_name" {
  description = "The name of the Kinesis stream"
  value       = aws_kinesis_stream.xfusion_stream.name
}

output "stream_arn" {
  description = "The ARN of the Kinesis stream"
  value       = aws_kinesis_stream.xfusion_stream.arn
}
