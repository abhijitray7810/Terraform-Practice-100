# Nautilus AWS Secrets Manager Terraform

Terraform configuration to securely store sensitive credentials in AWS Secrets Manager.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
![image](https://github.com/abhijitray7810/Terraform-Practice-100/blob/8624da9416753b1bb962d2fbff45daf7bb41a3d5/Day%2028%3A%20Secrets%20Manager%20Setup%20Using%20Terraform/Screenshot%202026-03-12%20194519.png)
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
