# Nautilus DevOps - AWS VPC Infrastructure

## Overview

This Terraform configuration creates the foundational VPC infrastructure for the Nautilus DevOps team's AWS cloud migration. The project follows an incremental migration approach, starting with Virtual Private Cloud (VPC) provisioning as the first step.

## Project Details

**VPC Name:** `datacenter-vpc`  
**Region:** `us-east-1`  
**IPv4 CIDR Block:** `10.0.0.0/16`  
**IPv6 CIDR Block:** Amazon-provided (automatically assigned)

## Prerequisites

Before you begin, ensure you have the following installed and configured:

- **Terraform** (version 1.0 or higher)
- **AWS CLI** configured with appropriate credentials
- **AWS Account** with necessary permissions to create VPC resources
- **VS Code** (optional, but recommended for development)

## AWS Credentials

Ensure your AWS credentials are configured. You can do this by:

1. Using AWS CLI: `aws configure`
2. Setting environment variables:
   ```bash
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   ```
3. Using AWS credentials file (`~/.aws/credentials`)

## Directory Structure

```
/home/bob/terraform/
├── main.tf       # Main Terraform configuration file
└── README.md     # This documentation file
```

## Deployment Instructions

### Step 1: Navigate to the Terraform Directory

Open VS Code and navigate to the Terraform working directory, or use the terminal:

```bash
cd /home/bob/terraform
```

### Step 2: Initialize Terraform

Initialize the Terraform working directory. This will download the necessary AWS provider plugins:

```bash
terraform init
```

Expected output: Terraform will download the AWS provider and display "Terraform has been successfully initialized!"

### Step 3: Validate Configuration

Validate the Terraform configuration to check for syntax errors:

```bash
terraform validate
```

### Step 4: Plan the Deployment

Generate and review the execution plan to see what resources will be created:

```bash
terraform plan
```

This command shows you what Terraform will create without actually making any changes.

### Step 5: Apply the Configuration

Create the VPC infrastructure:

```bash
terraform apply
```

When prompted, type `yes` to confirm and proceed with the resource creation.

### Step 6: Verify Deployment

After successful deployment, Terraform will display the outputs including:
- VPC ID
- IPv4 CIDR block
- IPv6 CIDR block

You can also verify the VPC creation in the AWS Console under VPC service.

## Configuration Details

### VPC Resource

The configuration creates a VPC with the following specifications:

- **Resource Type:** `aws_vpc`
- **IPv4 CIDR:** 10.0.0.0/16 (65,536 IP addresses)
- **IPv6 Support:** Enabled with Amazon-provided CIDR block
- **DNS Support:** Enabled by default
- **DNS Hostnames:** Enabled by default

### Outputs

The configuration provides the following outputs after deployment:

- `vpc_id`: The unique identifier of the created VPC
- `vpc_cidr_block`: The IPv4 CIDR block assigned to the VPC
- `vpc_ipv6_cidr_block`: The Amazon-provided IPv6 CIDR block

## Useful Commands

### View Current State

```bash
terraform show
```

### View Outputs

```bash
terraform output
```

### Format Configuration Files

```bash
terraform fmt
```

### Destroy Infrastructure

To remove all resources created by this configuration:

```bash
terraform destroy
```

**Warning:** This will permanently delete the VPC and all associated resources. Use with caution.

## Troubleshooting

### Issue: Authentication Errors

**Problem:** "Error: No valid credential sources found"

**Solution:** Ensure AWS credentials are properly configured using `aws configure` or environment variables.

### Issue: Permission Denied

**Problem:** "Error: UnauthorizedOperation"

**Solution:** Verify that your AWS IAM user/role has the necessary permissions to create VPC resources (ec2:CreateVpc, ec2:DescribeVpcs, etc.).

### Issue: Region Not Available

**Problem:** Resources cannot be created in the specified region

**Solution:** Ensure the `us-east-1` region is available for your AWS account.

## Next Steps

After successfully creating the VPC, the Nautilus DevOps team can proceed with:

1. Creating subnets (public and private)
2. Setting up Internet Gateway and NAT Gateway
3. Configuring route tables
4. Establishing security groups
5. Provisioning EC2 instances and other AWS services

## Best Practices

- Always run `terraform plan` before `terraform apply` to review changes
- Use version control (Git) to track infrastructure changes
- Store Terraform state files securely (consider using S3 backend with state locking)
- Tag resources appropriately for better organization and cost tracking
- Document any manual changes made outside of Terraform

## Support

For issues or questions related to this infrastructure:
- Contact the Nautilus DevOps team
- Review AWS VPC documentation: https://docs.aws.amazon.com/vpc/
- Check Terraform AWS provider documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

## Version History

- **v1.0** - Initial VPC creation with IPv4 and IPv6 CIDR blocks

---

**Project:** Nautilus Cloud Migration  
**Team:** DevOps  
**Last Updated:** December 2025
