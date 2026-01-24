# DevOps CloudFormation Stack

Terraform configuration to deploy a CloudFormation stack with an S3 bucket.

## Resources

- **CloudFormation Stack**: `devops-stack`
- **S3 Bucket**: `devops-bucket-30062` (versioning enabled)

## Usage

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Deploy infrastructure
terraform apply

# Destroy resources
terraform destroy
```

## Requirements

- Terraform installed
- AWS credentials configured
- Appropriate IAM permissions for CloudFormation and S3
