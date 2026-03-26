resource "aws_s3_bucket" "my_bucket" {
  bucket = "nautilus-cp-23482"
  acl    = "private"

  tags = {
    Name        = "nautilus-cp-23482"
  }
}
