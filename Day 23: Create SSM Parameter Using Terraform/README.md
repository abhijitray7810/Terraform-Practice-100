# AWS SSM Parameter Store with Terraform

This project demonstrates how to create and manage AWS Systems Manager (SSM) Parameter Store parameters using Terraform Infrastructure as Code.

## Overview

AWS SSM Parameter Store provides secure, hierarchical storage for configuration data management and secrets. This implementation creates a simple String parameter for datacenter configuration.

## Prerequisites

- Terraform installed (v1.0+)
- AWS CLI configured with appropriate credentials
- AWS account with SSM permissions

## Project Structure

```
terraform/
└── main.tf          # Main Terraform configuration file
```

## Configuration Details

**Parameter Specifications:**
- **Name**: `datacenter-ssm-parameter`
- **Type**: `String`
- **Value**: `datacenter-value`
- **Region**: `us-east-1`

## Usage

### 1. Initialize Terraform

```bash
cd /home/bob/terraform
terraform init
```

### 2. Validate Configuration

```bash
terraform validate
```

### 3. Review Execution Plan

```bash
terraform plan
```

### 4. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 5. Verify Parameter

```bash
# Using Terraform
terraform output

# Using AWS CLI
aws ssm get-parameter --name "datacenter-ssm-parameter" --region us-east-1
```

## Outputs

The configuration provides the following outputs:
- `parameter_name` - The name of the SSM parameter
- `parameter_type` - The type of the parameter
- `parameter_value` - The value stored in the parameter
- `parameter_arn` - The ARN of the parameter

## Cleanup

To remove the created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## SSM Parameter Types

- **String** - Plain text parameter (used in this project)
- **StringList** - Comma-separated list of values
- **SecureString** - Encrypted parameter using KMS

## Use Cases

- Configuration management
- Environment variables
- Feature flags
- Application secrets
- Database connection strings

## Additional Resources

- [AWS SSM Parameter Store Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
- [Terraform AWS SSM Parameter Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)

## Author

DevOps Team - xFusionCorp Industries

## License

This project is part of the DevOps 365 Days learning series.
