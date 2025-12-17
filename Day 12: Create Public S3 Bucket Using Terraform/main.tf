# S3 Bucket
resource "aws_s3_bucket" "datacenter_bucket" {
  bucket = "datacenter-s3-17111"

  tags = {
    Name        = "datacenter-s3-17111"
    Environment = "Migration"
    Purpose     = "Data Storage"
  }
}

# Disable Block Public Access settings to allow public access
resource "aws_s3_bucket_public_access_block" "datacenter_bucket_pab" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Enable bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "datacenter_bucket_ownership" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Set bucket ACL to public-read
resource "aws_s3_bucket_acl" "datacenter_bucket_acl" {
  depends_on = [
    aws_s3_bucket_public_access_block.datacenter_bucket_pab,
    aws_s3_bucket_ownership_controls.datacenter_bucket_ownership
  ]

  bucket = aws_s3_bucket.datacenter_bucket.id
  acl    = "public-read"
}

# Outputs
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.datacenter_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.datacenter_bucket.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.datacenter_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket regional domain name"
  value       = aws_s3_bucket.datacenter_bucket.bucket_regional_domain_name
}
