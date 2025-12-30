 # Nautilus AWS Security Group Terraform Project

## Overview

This Terraform project creates a security group for the Nautilus App Servers as part of the incremental migration strategy to AWS cloud. The security group is designed to allow HTTP and SSH access to the application servers.

## Project Structure

```
/home/bob/terraform/
├── main.tf          # Main Terraform configuration file
└── README.md        # Project documentation
```

## Requirements

### Prerequisites

- Terraform installed (version 0.12 or higher recommended)
- AWS CLI configured with appropriate credentials
- Access to AWS us-east-1 region
- Default VPC available in the AWS account

### Security Group Specifications

The Terraform configuration creates a security group with the following properties:

- **Name**: `nautilus-sg`
- **Description**: `Security group for Nautilus App Servers`
- **Region**: `us-east-1`
- **VPC**: Default VPC

### Inbound Rules

1. **HTTP Access**
   - Protocol: TCP
   - Port: 80
   - Source: 0.0.0.0/0 (Anywhere)

2. **SSH Access**
   - Protocol: TCP
   - Port: 22
   - Source: 0.0.0.0/0 (Anywhere)

### Outbound Rules

- All outbound traffic is allowed (standard practice for security groups)

## Deployment Instructions

### Step 1: Navigate to Terraform Directory
```bash
cd /home/bob/terraform
```

### Step 2: Initialize Terraform
```bash
terraform init
```
This command initializes the working directory and downloads the required AWS provider.

### Step 3: Review Execution Plan
```bash
terraform plan
```
Review the execution plan to verify what resources will be created.

### Step 4: Apply Configuration
```bash
terraform apply
```
Type `yes` when prompted to confirm the deployment.

### Step 5: Verify Deployment
After successful deployment, verify the security group in the AWS Management Console:
1. Go to EC2 Service
2. Navigate to Security Groups
3. Look for `nautilus-sg` in us-east-1 region

## Terraform Commands Reference

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize Terraform working directory |
| `terraform plan` | Generate and show execution plan |
| `terraform apply` | Apply changes to reach desired state |
| `terraform destroy` | Destroy all managed infrastructure |
| `terraform show` | Inspect current state |

## Security Considerations

- The current configuration allows SSH access from anywhere (0.0.0.0/0). In production, consider restricting this to specific IP ranges.
- HTTP access is open to the internet, which is appropriate for web servers.
- Regularly review and update security group rules as needed.

## Cleanup

To destroy the created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm destruction of all resources.

## Troubleshooting

### Common Issues

1. **AWS Credentials Not Found**
   - Ensure AWS CLI is configured with `aws configure`
   - Verify IAM permissions include EC2 security group management

2. **Default VPC Not Found**
   - Ensure a default VPC exists in us-east-1 region
   - Create a default VPC if needed via AWS Console or CLI

3. **Naming Conflicts**
   - Security group names must be unique within the VPC
   - Modify the name in `main.tf` if conflicts occur

## Support

For issues related to this Terraform configuration, contact the Nautilus DevOps team.

---

**Note**: This security group is part of the incremental migration strategy to AWS cloud. Ensure proper testing in staging before production deployment.
```

This README.md file provides comprehensive documentation for the Terraform project, including:
- Project overview and structure
- Prerequisites and requirements
- Detailed deployment instructions
- Security considerations
- Troubleshooting guide
- Cleanup instructions

The documentation follows best practices for Terraform projects and provides clear, step-by-step instructions for both deployment and maintenance.
