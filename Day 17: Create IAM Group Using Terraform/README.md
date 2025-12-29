# Kareem DevOps - IAM Group Terraform Configuration

This Terraform configuration creates an IAM group named `iamgroup_kareem` on AWS.

## Prerequisites

- Terraform installed
- AWS credentials configured
- Appropriate IAM permissions to create IAM groups

## Usage

Initialize Terraform:
```bash
terraform init
```

Preview changes:
```bash
terraform plan
```

Apply configuration:
```bash
terraform apply
```

Destroy resources (if needed):
```bash
terraform destroy
```

## Resources Created

- IAM Group: `iamgroup_kareem`

## Directory Structure

```
/home/bob/terraform/
├── main.tf
└── README.md
```
