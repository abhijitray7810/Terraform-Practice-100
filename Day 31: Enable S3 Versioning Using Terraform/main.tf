resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "nautilus-s3-15399"
  acl    = "private"

  tags = {
    Name = "nautilus-s3-15399"
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_ran_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
