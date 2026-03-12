# Nautilus AWS Secrets Manager Terraform

Terraform configuration to securely store sensitive credentials in AWS Secrets Manager.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
![image]()
## Secret Details

| Key | Value |
|-----|-------|
| `username` | admin |
| `password` | Namin123 |
![image]()
## Usage

```bash
cd /home/bob/terraform
terraform init
terraform apply -auto-approve
```
![image]()
## Resources Created

- **aws_secretsmanager_secret** — secret named `nautilus-secret`
- **aws_secretsmanager_secret_version** — stores `username` and `password` as a JSON key-value pair

## Outputs

| Name | Description |
|------|-------------|
| `secret_arn` | The ARN of the created secret |

## Verify

```bash
aws secretsmanager get-secret-value --secret-id nautilus-secret
```
