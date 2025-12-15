# AWS EBS Volume Migration - Nautilus DevOps

## Overview

This Terraform configuration is part of the Nautilus DevOps team's incremental AWS cloud migration strategy. It provisions an AWS EBS (Elastic Block Store) volume in the `us-east-1` region.

## Project Details

**Task**: Create an AWS EBS volume with specific requirements as part of the infrastructure migration.

### Volume Specifications

- **Name**: `datacenter-volume`
- **Type**: `gp3` (General Purpose SSD - 3rd generation)
- **Size**: `2 GiB`
- **Region**: `us-east-1`
- **Availability Zone**: `us-east-1a`

## Prerequisites

Before running this Terraform configuration, ensure you have:

1. **Terraform installed** (version 1.0 or later recommended)
   ```bash
   terraform --version
   ```

2. **AWS CLI configured** with appropriate credentials
   ```bash
   aws configure
   ```

3. **Required AWS permissions**:
   - `ec2:CreateVolume`
   - `ec2:DescribeVolumes`
   - `ec2:CreateTags`
   - `ec2:DeleteVolume` (for cleanup)

## Directory Structure

```
/home/bob/terraform/
├── main.tf       # Terraform configuration file
└── README.md     # This file
```

## Getting Started

### Step 1: Navigate to the Working Directory

Open the integrated terminal in VS Code:
- Right-click under the **EXPLORER** section
- Select **"Open in Integrated Terminal"**

Or use the command line:
```bash
cd /home/bob/terraform
```

### Step 2: Initialize Terraform

Initialize the Terraform working directory and download required providers:

```bash
terraform init
```

This command will:
- Download the AWS provider plugin
- Initialize the backend
- Create a `.terraform` directory

### Step 3: Validate the Configuration

Verify that the configuration is syntactically correct:

```bash
terraform validate
```

### Step 4: Review the Execution Plan

Preview the changes Terraform will make:

```bash
terraform plan
```

Expected output will show:
- 1 resource to be created (aws_ebs_volume)
- Volume specifications (type, size, tags)

### Step 5: Apply the Configuration

Create the EBS volume:

```bash
terraform apply
```

- Type `yes` when prompted to confirm
- Terraform will create the EBS volume and display the outputs

### Step 6: Verify the Volume

Check the outputs to confirm successful creation:
- **Volume ID**: Displayed in the output
- **Volume ARN**: Displayed in the output

You can also verify in the AWS Console:
1. Navigate to EC2 → Elastic Block Store → Volumes
2. Look for a volume named `datacenter-volume`

## Outputs

After successful deployment, you'll see:

```
Outputs:

volume_arn = "arn:aws:ec2:us-east-1:xxxxxxxxxxxx:volume/vol-xxxxxxxxxxxxxxxxx"
volume_id = "vol-xxxxxxxxxxxxxxxxx"
```

## Managing the Infrastructure

### View Current State

```bash
terraform show
```

### Update Configuration

1. Modify `main.tf` as needed
2. Run `terraform plan` to review changes
3. Run `terraform apply` to apply updates

### Destroy Resources

To remove the EBS volume when no longer needed:

```bash
terraform destroy
```

**Warning**: This will permanently delete the EBS volume and all data on it.

## Configuration Details

### Resource Block

```hcl
resource "aws_ebs_volume" "datacenter_volume" {
  availability_zone = "us-east-1a"
  size              = 2
  type              = "gp3"
  
  tags = {
    Name = "datacenter-volume"
  }
}
```

### gp3 Volume Benefits

- **Performance**: Baseline of 3,000 IOPS and 125 MiB/s throughput
- **Cost-effective**: 20% lower cost per GB than gp2
- **Scalable**: Performance can be independently adjusted from storage capacity

## Troubleshooting

### Common Issues

**Issue**: `Error: No valid credential sources found`
- **Solution**: Configure AWS credentials using `aws configure` or set environment variables

**Issue**: `Error: creating EBS Volume: UnauthorizedOperation`
- **Solution**: Ensure your IAM user/role has the necessary EC2 permissions

**Issue**: `Error: Insufficient capacity in the availability zone`
- **Solution**: Try changing the availability zone in `main.tf` (e.g., from `us-east-1a` to `us-east-1b`)

### Useful Commands

```bash
# Format Terraform files
terraform fmt

# Check for configuration issues
terraform validate

# Show current state
terraform state list

# Get detailed resource information
terraform state show aws_ebs_volume.datacenter_volume
```

## Best Practices

1. **Version Control**: Always commit `main.tf` to version control
2. **State Management**: Consider using remote state (S3 + DynamoDB) for team collaboration
3. **Tagging**: Use consistent tagging strategies for resource management
4. **Documentation**: Keep this README updated with any configuration changes

## Migration Strategy

This EBS volume creation is part of the Nautilus team's incremental migration approach:

✅ **Phase 1**: Create storage infrastructure (EBS volumes)  
⏳ **Phase 2**: Set up compute resources (EC2 instances)  
⏳ **Phase 3**: Configure networking (VPC, subnets, security groups)  
⏳ **Phase 4**: Deploy applications  

## Support

For questions or issues:
- Contact: Nautilus DevOps Team
- Documentation: [AWS EBS Documentation](https://docs.aws.amazon.com/ebs/)
- Terraform AWS Provider: [Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## License

Internal use - Nautilus DevOps Team

---

**Last Updated**: December 2025  
**Maintained By**: Nautilus DevOps Team
