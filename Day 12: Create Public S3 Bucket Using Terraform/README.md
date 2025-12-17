# Nautilus S3 Bucket - Terraform Configuration

This repository contains Terraform configuration to create a public S3 bucket for the Nautilus DevOps team's data migration process to AWS.

## Overview

This configuration creates a publicly accessible S3 bucket named `datacenter-s3-17111` in the `us-east-1` region. The bucket is configured with public-read ACL to support the data migration and storage requirements.

## Prerequisites

- Terraform installed (version 1.0 or higher)
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create and manage S3 buckets
- IAM permissions for S3 operations

## Bucket Specifications

| Parameter | Value | Description |
|-----------|-------|-------------|
| **Bucket Name** | `datacenter-s3-17111` | Unique identifier for the S3 bucket |
| **Region** | `us-east-1` | AWS region where bucket is created |
| **ACL** | `public-read` | Allows public read access to objects |
| **Public Access** | `Enabled` | All block public access settings disabled |
| **Object Ownership** | `BucketOwnerPreferred` | Enables ACL-based access control |

## File Structure

```
/home/bob/terraform/
├── main.tf          # Main Terraform configuration file
└── README.md        # This documentation file
```

## Configuration Components

### 1. S3 Bucket Resource

Creates the main S3 bucket with the specified name and tags for organization.

### 2. Public Access Block Settings

Disables all block public access settings to allow the bucket to be publicly accessible:
- `block_public_acls = false`
- `block_public_policy = false`
- `ignore_public_acls = false`
- `restrict_public_buckets = false`

### 3. Ownership Controls

Configures bucket ownership to `BucketOwnerPreferred`, which allows the use of ACLs for access control.

### 4. Bucket ACL

Sets the Access Control List to `public-read`, enabling public read access to bucket contents.

## Usage

### 1. Navigate to the Terraform Directory

```bash
cd /home/bob/terraform
```

### 2. Initialize Terraform

Download the required AWS provider and initialize the working directory:

```bash
terraform init
```

Expected output:
```
Initializing the backend...
Initializing provider plugins...
Terraform has been successfully initialized!
```

### 3. Validate Configuration

Check for syntax errors and configuration issues:

```bash
terraform validate
```

### 4. Review the Execution Plan

Preview all resources that will be created:

```bash
terraform plan
```

This will show:
- 1 S3 bucket to be created
- 1 public access block configuration
- 1 ownership controls configuration
- 1 bucket ACL configuration

### 5. Apply the Configuration

Create the S3 bucket and associated resources:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 6. Verify Deployment

After successful deployment, Terraform will display outputs including:
- Bucket name
- Bucket ARN
- Bucket domain name
- Regional domain name

## Accessing the Bucket

### Via AWS Console

1. Navigate to **S3** in the AWS Console
2. Search for `datacenter-s3-17111`
3. Click on the bucket to view contents and settings

### Via AWS CLI

```bash
# List bucket contents
aws s3 ls s3://datacenter-s3-17111/

# Upload a file
aws s3 cp myfile.txt s3://datacenter-s3-17111/

# Download a file
aws s3 cp s3://datacenter-s3-17111/myfile.txt ./
```

### Public URL Access

Once files are uploaded, they can be accessed publicly via:

```
https://datacenter-s3-17111.s3.amazonaws.com/filename.ext
```

Or using the regional domain:

```
https://datacenter-s3-17111.s3.us-east-1.amazonaws.com/filename.ext
```

## Uploading Files

### Using AWS CLI

```bash
# Upload a single file
aws s3 cp localfile.txt s3://datacenter-s3-17111/

# Upload a directory recursively
aws s3 cp ./local-folder/ s3://datacenter-s3-17111/remote-folder/ --recursive

# Sync a directory
aws s3 sync ./local-folder/ s3://datacenter-s3-17111/remote-folder/
```

### Using Terraform (Optional)

Add objects to `main.tf`:

```hcl
resource "aws_s3_object" "example_file" {
  bucket = aws_s3_bucket.datacenter_bucket.id
  key    = "example.txt"
  source = "path/to/local/file.txt"
  acl    = "public-read"
}
```

## Security Considerations

⚠️ **IMPORTANT SECURITY NOTICE**

This bucket is configured for **PUBLIC ACCESS**. Please be aware:

1. **Data Sensitivity**: Only store non-sensitive, public data in this bucket
2. **Access Control**: Anyone with the URL can access objects in this bucket
3. **Cost Implications**: Public buckets may incur unexpected data transfer costs if accessed frequently
4. **Compliance**: Ensure this configuration meets your organization's security and compliance requirements
5. **Monitoring**: Regularly review bucket access logs and CloudTrail events

### Recommended Security Practices

- **Never store**: Credentials, PII, confidential data, or sensitive business information
- **Use versioning**: Enable versioning to protect against accidental deletions
- **Enable logging**: Set up S3 access logging for audit purposes
- **Regular audits**: Periodically review bucket contents and access patterns
- **Cost monitoring**: Set up billing alerts to monitor unexpected data transfer costs

## Making the Bucket Private (If Needed)

If you need to convert this to a private bucket, modify the ACL:

```hcl
resource "aws_s3_bucket_acl" "datacenter_bucket_acl" {
  bucket = aws_s3_bucket.datacenter_bucket.id
  acl    = "private"  # Change from public-read to private
}
```

Or enable block public access:

```hcl
resource "aws_s3_bucket_public_access_block" "datacenter_bucket_pab" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

## Advanced Configuration

### Enable Versioning

Add versioning to protect against accidental deletions:

```hcl
resource "aws_s3_bucket_versioning" "datacenter_bucket_versioning" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
```

### Enable Server-Side Encryption

Add encryption at rest:

```hcl
resource "aws_s3_bucket_server_side_encryption_configuration" "datacenter_bucket_encryption" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

### Enable Access Logging

Track bucket access:

```hcl
resource "aws_s3_bucket" "log_bucket" {
  bucket = "datacenter-s3-17111-logs"
}

resource "aws_s3_bucket_logging" "datacenter_bucket_logging" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "access-logs/"
}
```

### Add Lifecycle Rules

Automatically transition or expire objects:

```hcl
resource "aws_s3_bucket_lifecycle_configuration" "datacenter_bucket_lifecycle" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  rule {
    id     = "archive-old-files"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}
```

## Outputs

The configuration provides the following outputs:

| Output | Description | Example Value |
|--------|-------------|---------------|
| `bucket_name` | The name of the bucket | datacenter-s3-17111 |
| `bucket_arn` | The Amazon Resource Name | arn:aws:s3:::datacenter-s3-17111 |
| `bucket_domain_name` | The bucket domain name | datacenter-s3-17111.s3.amazonaws.com |
| `bucket_regional_domain_name` | Regional domain name | datacenter-s3-17111.s3.us-east-1.amazonaws.com |

View outputs after applying:

```bash
terraform output
```

View specific output:

```bash
terraform output bucket_name
```

## Cleanup

To remove all created resources:

```bash
# Note: The bucket must be empty before deletion
aws s3 rm s3://datacenter-s3-17111/ --recursive

# Then destroy Terraform resources
terraform destroy
```

Type `yes` when prompted to confirm deletion.

### Force Delete Non-Empty Bucket

If you need to delete the bucket with contents:

```bash
aws s3 rb s3://datacenter-s3-17111 --force
terraform destroy
```

## Troubleshooting

### Bucket Already Exists Error

**Error**: `BucketAlreadyExists` or `BucketAlreadyOwnedByYou`

**Solution**: S3 bucket names must be globally unique. Either:
- Delete the existing bucket, or
- Choose a different bucket name in `main.tf`

### Access Denied Errors

**Error**: `AccessDenied` when creating bucket

**Solution**: Ensure your AWS credentials have the following permissions:
- `s3:CreateBucket`
- `s3:PutBucketAcl`
- `s3:PutBucketPublicAccessBlock`
- `s3:PutBucketOwnershipControls`

### Public Access Still Blocked

**Error**: Objects are not publicly accessible

**Solution**: 
1. Verify public access block settings are all `false`
2. Ensure object ACL is also set to `public-read` when uploading
3. Check for account-level public access blocks in AWS Console

### Terraform State Lock

**Error**: `Error acquiring the state lock`

**Solution**:
```bash
# If using local state
rm -rf .terraform/
terraform init

# If no one else is running terraform
terraform force-unlock <LOCK_ID>
```

## Cost Estimation

### Storage Costs (us-east-1)
- **Standard Storage**: ~$0.023 per GB/month
- **First 50 TB/month**: Data transfer OUT is charged
- **PUT/POST Requests**: ~$0.005 per 1,000 requests
- **GET Requests**: ~$0.0004 per 1,000 requests

### Cost Optimization Tips
1. Use lifecycle policies to move old data to cheaper storage classes
2. Enable S3 Intelligent-Tiering for automatic cost optimization
3. Monitor data transfer costs for public buckets
4. Delete unnecessary objects regularly

## Compliance and Best Practices

1. **Data Classification**: Document what type of data is stored
2. **Access Reviews**: Regularly review who/what has access
3. **Encryption**: Consider enabling encryption even for public buckets
4. **Monitoring**: Set up CloudWatch alarms for unusual activity
5. **Tagging**: Use consistent tags for cost allocation and organization
6. **Documentation**: Keep this README updated with any changes

## Migration Checklist

- [ ] Terraform configuration deployed successfully
- [ ] Bucket accessibility verified via public URL
- [ ] Sample data uploaded and tested
- [ ] Access logs configured (if required)
- [ ] Cost monitoring alerts set up
- [ ] Team notified of bucket availability
- [ ] Migration plan documented
- [ ] Backup strategy defined
- [ ] Compliance requirements verified

## Additional Resources

- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [Terraform AWS S3 Bucket Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [S3 Security Best Practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)
- [S3 Pricing](https://aws.amazon.com/s3/pricing/)
- [Managing Public Access to S3 Buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html)

## Support

For issues or questions:
- Contact the Nautilus DevOps team
- Review AWS S3 documentation
- Check Terraform AWS provider documentation
- Submit issues to the infrastructure repository

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| Dec 2025 | 1.0 | Initial public S3 bucket configuration | Nautilus DevOps |

---

**Project**: Data Migration to AWS  
**Created by**: Nautilus DevOps Team  
**Last Updated**: December 2025  
**Version**: 1.0  
**Status**: Active
