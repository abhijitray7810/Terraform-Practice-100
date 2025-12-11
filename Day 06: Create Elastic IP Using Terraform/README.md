# AWS Elastic IP Allocation with Terraform

## Overview

This Terraform configuration is part of the Nautilus DevOps team's incremental AWS cloud migration strategy. It allocates an Elastic IP address named `xfusion-eip` to support the gradual infrastructure migration process.

## Project Structure

```
/home/bob/terraform/
├── main.tf       # Main Terraform configuration file
└── README.md     # This file
```

## Prerequisites

Before running this Terraform configuration, ensure you have:

1. **Terraform installed** (version 1.0 or later recommended)
   ```bash
   terraform version
   ```

2. **AWS CLI configured** with appropriate credentials
   ```bash
   aws configure
   ```

3. **Required AWS permissions** for your IAM user/role:
   - `ec2:AllocateAddress`
   - `ec2:DescribeAddresses`
   - `ec2:CreateTags`
   - `ec2:ReleaseAddress` (for cleanup)

## Configuration Details

### Resources Created

- **AWS Elastic IP** (`aws_eip.xfusion_eip`)
  - Name: `xfusion-eip`
  - Domain: VPC
  - Region: `us-east-1` (configurable)

### Outputs

- `elastic_ip`: The allocated public IP address
- `allocation_id`: The Elastic IP allocation ID

## Usage Instructions

### Step 1: Navigate to the Working Directory

Open the integrated terminal in VS Code (right-click under EXPLORER section) and navigate to the Terraform directory:

```bash
cd /home/bob/terraform
```

### Step 2: Initialize Terraform

Download the required provider plugins:

```bash
terraform init
```

### Step 3: Validate Configuration

Verify the configuration syntax:

```bash
terraform validate
```

### Step 4: Review Execution Plan

Preview the changes Terraform will make:

```bash
terraform plan
```

### Step 5: Apply Configuration

Create the Elastic IP resource:

```bash
terraform apply
```

Type `yes` when prompted to confirm the action.

### Step 6: View Outputs

After successful application, Terraform will display the allocated Elastic IP address and allocation ID. You can also view outputs anytime with:

```bash
terraform output
```

## Configuration Customization

### Change AWS Region

Edit the `provider` block in `main.tf`:

```hcl
provider "aws" {
  region = "us-west-2"  # Change to your preferred region
}
```

### Add Additional Tags

Modify the `tags` block in the `aws_eip` resource:

```hcl
tags = {
  Name        = "xfusion-eip"
  Environment = "production"
  Project     = "nautilus-migration"
  ManagedBy   = "terraform"
}
```

## Managing the Infrastructure

### View Current State

```bash
terraform show
```

### Check Resource Status

```bash
terraform state list
```

### Destroy Resources

When you need to remove the Elastic IP:

```bash
terraform destroy
```

Type `yes` when prompted to confirm deletion.

## Troubleshooting

### Common Issues

1. **Authentication Errors**
   - Ensure AWS credentials are properly configured
   - Verify IAM permissions

2. **Region Availability**
   - Confirm Elastic IPs are available in your selected region
   - Check AWS account limits for Elastic IPs

3. **State File Issues**
   - Ensure `terraform.tfstate` is not corrupted
   - Keep state files secure and backed up

### Useful Commands

```bash
# Format Terraform files
terraform fmt

# Show detailed logs
export TF_LOG=DEBUG
terraform apply

# Refresh state
terraform refresh
```

## Best Practices

1. **Version Control**: Commit `main.tf` and `README.md` to Git (exclude `terraform.tfstate` and `.terraform/`)
2. **State Management**: Consider using remote state (S3 + DynamoDB) for team collaboration
3. **Resource Tagging**: Always tag resources for better organization and cost tracking
4. **Incremental Changes**: Test configurations in development before applying to production

## Migration Strategy

This Elastic IP allocation is part of a larger incremental migration approach:

- Breaking down large tasks into smaller, manageable units
- Executing migration in gradual phases
- Minimizing disruption to ongoing operations
- Enabling better control and risk mitigation

## Support

For issues or questions related to this Terraform configuration:

- Review Terraform documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
- Check AWS Elastic IP documentation: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html
- Contact the Nautilus DevOps team

## License

Internal use for Nautilus DevOps team migration project.

---

**Last Updated**: December 2025  
**Maintained By**: Nautilus DevOps Team
