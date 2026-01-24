resource "aws_cloudformation_stack" "devops-stack" {
  name = "devops-stack"

  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Description = "CloudFormation stack for DevOps S3 bucket with versioning"
    
    Resources = {
      DevOpsS3Bucket = {
        Type = "AWS::S3::Bucket"
        Properties = {
          BucketName = "devops-bucket-30062"
          VersioningConfiguration = {
            Status = "Enabled"
          }
        }
      }
    }
    
    Outputs = {
      BucketName = {
        Description = "Name of the S3 bucket"
        Value = {
          Ref = "DevOpsS3Bucket"
        }
      }
      BucketArn = {
        Description = "ARN of the S3 bucket"
        Value = {
          "Fn::GetAtt" = ["DevOpsS3Bucket", "Arn"]
        }
      }
    }
  })
}

output "stack_id" {
  description = "CloudFormation Stack ID"
  value       = aws_cloudformation_stack.devops-stack.id
}

output "bucket_name" {
  description = "S3 Bucket Name"
  value       = "devops-bucket-30062"
}
