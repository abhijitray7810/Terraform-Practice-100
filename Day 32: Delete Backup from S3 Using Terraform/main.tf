terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"   # adjust if your bucket is in a different region
}

# Step 1: Copy S3 bucket contents to /opt/s3-backup/
resource "null_resource" "copy_s3_to_local" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p /opt/s3-backup
      aws s3 cp s3://datacenter-bck-26646/ /opt/s3-backup/ --recursive
    EOT
  }
}

# Step 2: Empty the bucket first, then delete it
resource "null_resource" "delete_s3_bucket" {
  depends_on = [null_resource.copy_s3_to_local]

  provisioner "local-exec" {
    command = <<EOT
      aws s3 rm s3://datacenter-bck-26646 --recursive
      aws s3api delete-bucket --bucket datacenter-bck-26646 --region us-east-1
    EOT
  }
}
