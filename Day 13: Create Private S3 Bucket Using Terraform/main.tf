# Create the S3 bucket
resource "aws_s3_bucket" "xfusion_bucket" {
  bucket = "xfusion-s3-9989"

  tags = {
    Name        = "xfusion-s3-9989"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# Block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "xfusion_bucket_pab" {
  bucket = aws_s3_bucket.xfusion_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Output the bucket name and ARN
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.xfusion_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.xfusion_bucket.arn
}
