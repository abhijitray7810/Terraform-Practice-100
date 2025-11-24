# Nautilus AWS VPC Migration Project

## Overview

This Terraform project is part of the Nautilus DevOps team's incremental migration strategy to AWS cloud infrastructure. This phase focuses on creating the foundational VPC (Virtual Private Cloud) in the US East region.

## Project Structure

```
/home/bob/terraform/
├── main.tf       # Main Terraform configuration file
└── README.md     # This documentation file
```

## Infrastructure Components

### VPC Configuration
- **VPC Name**: `xfusion-vpc`
- **Region**: `us-east-1`
- **IPv4 CIDR Block**: `10.0.0.0/16`
- **IP Address Range**: 65,536 available IP addresses
- **DNS Support**: Enabled
- **DNS Hostnames**: Enabled

## Prerequisites

Before running this Terraform configuration, ensure you have:

1. **Terraform Installed**: Version 1.0 or higher
2. **AWS CLI Configured**: With appropriate credentials
3. **AWS IAM Permissions**: Required permissions to create VPC resources
4. **Access Keys**: Valid AWS access key ID and secret access key

## Getting Started

### Step 1: Navigate to the Terraform Directory

```bash
cd /home/bob/terraform
```

### Step 2: Initialize Terraform

This command downloads the required AWS provider plugins:

```bash
terraform init
```

### Step 3: Validate Configuration

Check for syntax errors:

```bash
terraform validate
```

### Step 4: Plan the Deployment

Preview the resources that will be created:

```bash
terraform plan
```

### Step 5: Apply the Configuration

Create the VPC infrastructure:

```bash
terraform apply
```

When prompted, type `yes` to confirm the creation.

### Step 6: Verify Deployment

After successful deployment, verify the VPC was created:

```bash
terraform show
```

Or check in the AWS Console under VPC services in the us-east-1 region.

## Terraform Commands Reference

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize the working directory |
| `terraform validate` | Validate the configuration files |
| `terraform plan` | Preview changes before applying |
| `terraform apply` | Create or update infrastructure |
| `terraform destroy` | Remove all resources (use with caution) |
| `terraform show` | Display current state |
| `terraform output` | Show output values |

## AWS Resources Created

This configuration will create the following AWS resources:

- 1 × VPC (Virtual Private Cloud)

## Migration Strategy

This VPC creation is **Phase 1** of the Nautilus infrastructure migration. The incremental approach allows for:

- **Better Control**: Systematic progress through each stage
- **Risk Mitigation**: Smaller changes reduce potential impact
- **Resource Optimization**: Efficient allocation and management
- **Minimal Disruption**: Gradual transition maintains operational stability

## Future Phases

Subsequent migration phases may include:

- Subnets (public and private)
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- EC2 Instances
- Load Balancers
- Database Services

## Configuration Details

### CIDR Block Selection

The `10.0.0.0/16` CIDR block provides:
- **Network Address**: 10.0.0.0
- **Broadcast Address**: 10.0.255.255
- **Usable IPs**: 10.0.0.1 to 10.0.255.254
- **Total Addresses**: 65,536

This range can be subdivided into smaller subnets for different tiers (web, application, database) in future phases.

## Troubleshooting

### Common Issues

**Issue**: `Error: No valid credential sources found`
- **Solution**: Configure AWS credentials using `aws configure` or set environment variables

**Issue**: `Error: creating EC2 VPC: UnauthorizedOperation`
- **Solution**: Ensure your IAM user/role has VPC creation permissions

**Issue**: `Error: CIDR block conflicts`
- **Solution**: Modify the CIDR block in `main.tf` to use a different range

### Getting Help

If you encounter issues:
1. Check the Terraform output for detailed error messages
2. Review AWS CloudWatch logs
3. Verify IAM permissions
4. Consult the team's DevOps documentation

## Cleanup

To remove all resources created by this configuration:

```bash
terraform destroy
```

**Warning**: This will permanently delete the VPC and all associated resources.

## Best Practices

- Always run `terraform plan` before `terraform apply`
- Keep state files secure and backed up
- Use version control for Terraform configurations
- Document any manual changes made outside Terraform
- Review and audit infrastructure changes regularly

## Support

For questions or issues related to this migration phase, contact the Nautilus DevOps team.

## Version History

- **v1.0**: Initial VPC creation in us-east-1 region

---

**Last Updated**: November 2025  
**Maintained By**: Nautilus DevOps Team
