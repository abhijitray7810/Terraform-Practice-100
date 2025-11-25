# Nautilus DevOps - AWS VPC Migration

## Overview
This Terraform configuration creates the foundational VPC infrastructure for the Nautilus DevOps team's incremental AWS cloud migration strategy.

## Infrastructure Details

### VPC Configuration
- **VPC Name**: datacenter-vpc
- **Region**: us-east-1
- **IPv4 CIDR Block**: 192.168.0.0/24
- **DNS Support**: Enabled
- **DNS Hostnames**: Enabled

## Prerequisites

1. **Terraform**: Ensure Terraform is installed (version 1.0 or later recommended)
2. **AWS Credentials**: Configure AWS credentials using one of the following methods:
   - AWS CLI: `aws configure`
   - Environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
   - AWS credentials file: `~/.aws/credentials`
3. **IAM Permissions**: Ensure your AWS user/role has permissions to create VPCs

## Deployment Steps

### 1. Open Terminal
Right-click under the EXPLORER section in VS Code and select **Open in Integrated Terminal**

### 2. Navigate to Terraform Directory
```bash
cd /home/bob/terraform
```

### 3. Initialize Terraform
```bash
terraform init
```
This downloads the AWS provider and initializes the working directory.

### 4. Validate Configuration
```bash
terraform validate
```
Verifies the syntax and configuration are correct.

### 5. Preview Changes
```bash
terraform plan
```
Shows what resources will be created without actually creating them.

### 6. Apply Configuration
```bash
terraform apply
```
Type `yes` when prompted to create the VPC.

### 7. Verify Deployment
After successful deployment, Terraform will output:
- VPC ID
- VPC CIDR block

## Outputs

The configuration provides the following outputs:
- **vpc_id**: The unique identifier of the created VPC
- **vpc_cidr**: The CIDR block assigned to the VPC

## Viewing Resources

### Check VPC in AWS Console
1. Navigate to AWS Console → VPC Dashboard
2. Look for VPC named "datacenter-vpc" in us-east-1 region

### Using Terraform
```bash
terraform show
```

### Using AWS CLI
```bash
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=datacenter-vpc" --region us-east-1
```

## Clean Up (When Needed)

To destroy the VPC and all associated resources:
```bash
terraform destroy
```
Type `yes` when prompted.

## Next Steps

With the VPC created, the team can proceed with:
1. Creating subnets within the VPC
2. Setting up Internet Gateways
3. Configuring route tables
4. Deploying EC2 instances and other AWS services
5. Implementing security groups and network ACLs

## File Structure
```
/home/bob/terraform/
├── main.tf          # Main Terraform configuration
└── README.md        # This documentation file
```

## Troubleshooting

### Common Issues

**Issue**: "Error: No valid credential sources found"
- **Solution**: Configure AWS credentials using `aws configure`

**Issue**: "Error: creating EC2 VPC: UnauthorizedOperation"
- **Solution**: Ensure your IAM user/role has `ec2:CreateVpc` permission

**Issue**: "Error: CIDR block conflicts with existing VPC"
- **Solution**: Check for existing VPCs with overlapping CIDR ranges

## Support

For issues or questions regarding this infrastructure:
1. Check Terraform documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
2. Review AWS VPC documentation: https://docs.aws.amazon.com/vpc/
3. Contact the Nautilus DevOps team

## Version History

- **v1.0**: Initial VPC creation for datacenter migration
