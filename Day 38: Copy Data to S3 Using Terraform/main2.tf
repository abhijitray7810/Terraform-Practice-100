resource "aws_s3_bucket" "my_bucket" {
  bucket = "nautilus-cp-23482"
  acl    = "private"

  tags = {
    Name = "nautilus-cp-23482"
  }
}

resource "aws_s3_object" "nautilus_upload" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "nautilus.txt"
  source = "/tmp/nautilus.txt"
}
