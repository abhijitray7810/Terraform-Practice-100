# AWS S3 Bucket Terraform Configuration

## Overview

This Terraform configuration creates a private S3 bucket on AWS for the Nautilus DevOps team's data migration process. The bucket is configured with complete public access blocking to ensure data security.

## Project Details

- **Bucket Name**: `xfusion-s3-9989`
- **Region**: `us-east-1`
- **Access Level**: Private (all public access blocked)
- **Working Directory**: `/home/bob/terraform`

## Prerequisites

Before running this Terraform configuration, ensure you have:

1. **Terraform Installed**: Version 0.12 or later
2. **AWS CLI Configured**: With valid credentials
3. **IAM Permissions**: Your AWS user/role must have permissions to:
   - Create S3 buckets
   - Manage S3 bucket public access settings

## Configuration Files

- `main.tf`: Contains all Terraform resources for S3 bucket provisioning

## Resources Created

This configuration creates the following AWS resources:

1. **aws_s3_bucket**: The main S3 bucket resource
2. **aws_s3_bucket_public_access_block**: Blocks all public access to the bucket

## Getting Started

### 1. Navigate to the Working Directory

```bash
cd /home/bob/terraform
```

### 2. Initialize Terraform

Download the required AWS provider plugin:

```bash
terraform init
```

### 3. Validate Configuration

Check for syntax errors:

```bash
terraform validate
```

### 4. Plan the Deployment

Preview the resources that will be created:

```bash
terraform plan
```

### 5. Apply the Configuration

Create the resources:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

## Public Access Block Settings

The bucket is configured with all four public access block settings enabled:

| Setting | Value | Description |
|---------|-------|-------------|
| `block_public_acls` | `true` | Blocks public ACLs on the bucket and objects |
| `block_public_policy` | `true` | Blocks public bucket policies |
| `ignore_public_acls` | `true` | Ignores all public ACLs on the bucket and objects |
| `restrict_public_buckets` | `true` | Restricts public bucket policies |

This ensures the bucket remains completely private.

## Outputs

After successful deployment, Terraform will display:

- **bucket_name**: The name of the created S3 bucket
- **bucket_arn**: The Amazon Resource Name (ARN) of the bucket

## Verification

To verify the bucket was created successfully:

```bash
# List S3 buckets
aws s3 ls

# Check bucket public access block configuration
aws s3api get-public-access-block --bucket xfusion-s3-9989
```

## Managing the Infrastructure

### View Current State

```bash
terraform show
```

### Update Configuration

1. Modify `main.tf` as needed
2. Run `terraform plan` to preview changes
3. Run `terraform apply` to apply changes

### Destroy Resources

To remove all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm deletion.

## Troubleshooting

### Common Issues

**Issue**: "Error: error creating S3 bucket: BucketAlreadyExists"
- **Solution**: S3 bucket names must be globally unique. Choose a different bucket name.

**Issue**: "Error: No valid credential sources found"
- **Solution**: Configure AWS credentials using `aws configure` or set environment variables.

**Issue**: "Error: Insufficient IAM permissions"
- **Solution**: Ensure your AWS user/role has the necessary S3 permissions.

## Best Practices

1. **State Management**: Consider using remote state storage (S3 + DynamoDB) for team collaboration
2. **Versioning**: Enable bucket versioning for data protection
3. **Encryption**: Add server-side encryption for enhanced security
4. **Lifecycle Policies**: Implement lifecycle rules for cost optimization
5. **Logging**: Enable S3 access logging for audit trails

## Additional Configuration Options

To enhance the bucket configuration, you can add:

- **Versioning**: Track object versions
- **Encryption**: Enable server-side encryption (SSE-S3, SSE-KMS)
- **Lifecycle Rules**: Automate object transitions and deletions
- **Replication**: Configure cross-region replication
- **Logging**: Enable access logging

## Support

For issues or questions:
- Review AWS S3 documentation: https://docs.aws.amazon.com/s3/
- Check Terraform AWS provider docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

## Authors

Nautilus DevOps Team

## License

Internal use only - Nautilus DevOps Team
