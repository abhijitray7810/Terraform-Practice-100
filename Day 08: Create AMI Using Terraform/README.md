# Nautilus DevOps - AWS AMI Creation with Terraform

## Overview

This Terraform project is part of the Nautilus DevOps team's incremental migration strategy to AWS cloud. This specific task focuses on creating an Amazon Machine Image (AMI) from an existing EC2 instance to facilitate infrastructure migration in manageable phases.

## Project Details

### Objective
Create an AMI from an existing EC2 instance named `datacenter-ec2` using Terraform infrastructure as code.

### Specifications
- **Source EC2 Instance**: `datacenter-ec2`
- **AMI Name**: `datacenter-ec2-ami`
- **Expected AMI State**: `available`
- **Working Directory**: `/home/bob/terraform`
- **Configuration File**: `main.tf`

## Prerequisites

Before running this Terraform configuration, ensure you have:

1. **Terraform Installed**: Version 0.12 or higher
2. **AWS CLI Configured**: With appropriate credentials and permissions
3. **AWS Permissions**: IAM permissions to:
   - Describe EC2 instances
   - Create AMIs
   - Create snapshots (for EBS volumes)
   - Tag resources
4. **Existing EC2 Instance**: The `datacenter-ec2` instance must exist and be in a running or stopped state

## Project Structure

```
/home/bob/terraform/
├── main.tf           # Main Terraform configuration
└── README.md         # This documentation file
```

## Configuration Components

### Data Source
- **`aws_instance`**: Locates the existing EC2 instance by name tag and state

### Resources
- **`aws_ami_from_instance`**: Creates an AMI from the source EC2 instance

### Outputs
- **`ami_id`**: The unique identifier of the created AMI
- **`ami_state`**: The current state of the AMI (pending/available)
- **`ami_name`**: The name of the created AMI

## Usage Instructions

### Step 1: Navigate to Working Directory

Using VS Code:
1. Right-click under the `EXPLORER` section
2. Select `Open in Integrated Terminal`

Or use command line:
```bash
cd /home/bob/terraform
```

### Step 2: Initialize Terraform

Initialize the Terraform working directory and download required providers:

```bash
terraform init
```

### Step 3: Validate Configuration

Verify the configuration syntax is correct:

```bash
terraform validate
```

Expected output:
```
Success! The configuration is valid.
```

### Step 4: Review Execution Plan

Preview the changes Terraform will make:

```bash
terraform plan
```

Review the output to ensure:
- The correct EC2 instance is identified
- The AMI will be created with the correct name

### Step 5: Apply Configuration

Execute the Terraform configuration to create the AMI:

```bash
terraform apply
```

When prompted, type `yes` to confirm the action.

### Step 6: Monitor AMI Creation

The AMI creation process will begin. You can monitor progress by:

**Check Terraform outputs:**
```bash
terraform output
```

**Refresh Terraform state:**
```bash
terraform refresh
terraform output ami_state
```

**Use AWS CLI:**
```bash
aws ec2 describe-images --image-ids $(terraform output -raw ami_id)
```

## Expected Behavior

### AMI Creation Process

1. **Initial State**: AMI state will be `pending`
2. **Duration**: Creation time varies based on:
   - Instance size
   - Number of EBS volumes
   - Volume sizes
   - Typically takes 5-15 minutes
3. **Instance Impact**: The source EC2 instance may be briefly stopped during snapshot creation
4. **Final State**: AMI state will transition to `available` when ready

### Success Criteria

The task is complete when:
- ✅ AMI is created with name `datacenter-ec2-ami`
- ✅ AMI state is `available`
- ✅ AMI ID is displayed in Terraform outputs
- ✅ AMI is visible in AWS Console under EC2 > AMIs

## Verification

### Verify AMI in AWS Console

1. Navigate to EC2 Dashboard
2. Select "AMIs" from the left sidebar
3. Search for `datacenter-ec2-ami`
4. Verify the state is `available`

### Verify Using AWS CLI

```bash
aws ec2 describe-images \
  --filters "Name=name,Values=datacenter-ec2-ami" \
  --query 'Images[*].[ImageId,Name,State]' \
  --output table
```

### Verify Using Terraform

```bash
terraform show
terraform output
```

## Troubleshooting

### Common Issues

**Issue**: `Error: no matching EC2 Instance found`
- **Solution**: Verify the EC2 instance exists and is named `datacenter-ec2`
- Check instance tags in AWS Console

**Issue**: `Error: insufficient permissions`
- **Solution**: Ensure AWS credentials have EC2 and AMI creation permissions
- Required permissions: `ec2:CreateImage`, `ec2:DescribeInstances`, `ec2:CreateSnapshot`

**Issue**: AMI stuck in `pending` state
- **Solution**: This is normal. Wait for the process to complete (5-15 minutes)
- Check AWS Console for any error messages

**Issue**: Instance stops unexpectedly
- **Solution**: AWS temporarily stops instances during AMI creation from EBS-backed instances
- The instance will automatically restart after snapshot creation

## Cleanup (Optional)

To remove the created AMI (if needed):

```bash
terraform destroy
```

**Warning**: This will deregister the AMI and delete associated snapshots.

## Migration Strategy Context

This task is part of Nautilus DevOps team's incremental migration approach:

- **Phase**: Infrastructure Replication
- **Purpose**: Create portable instance images for migration
- **Benefits**:
  - Reproducible instance configurations
  - Quick instance deployment from AMIs
  - Backup and disaster recovery capability
  - Facilitates gradual migration phases

## Best Practices

1. **Tag Management**: Always tag AMIs with meaningful names and metadata
2. **Documentation**: Document the source instance configuration
3. **Testing**: Test AMI by launching a test instance before production use
4. **Lifecycle Management**: Implement AMI lifecycle policies to manage old images
5. **Security**: Ensure AMIs don't contain sensitive data or credentials

## Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS AMI Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

## Support

For issues or questions related to this migration task:
- Contact: Nautilus DevOps Team
- Review Terraform logs: Check `.terraform/` directory for detailed logs
- AWS Support: Use AWS Support Console for AWS-specific issues

---

**Project**: Nautilus AWS Migration  
**Task**: AMI Creation from Existing EC2 Instance  
**Status**: Ready for Execution  
**Last Updated**: December 2025
