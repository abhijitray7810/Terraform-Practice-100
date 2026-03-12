# DevOps OpenSearch Terraform

Terraform configuration to provision an Amazon OpenSearch Service domain for storing and searching application logs.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS CLI configured with appropriate credentials

## Usage

```bash
cd /home/bob/terraform
terraform init
terraform apply -auto-approve
```

## Resources Created

- **aws_opensearch_domain** — domain named `devops-es` (OpenSearch 2.11, t3.small, 10GB EBS)

## Outputs

| Name | Description |
|------|-------------|
| `opensearch_endpoint` | The endpoint URL of the OpenSearch domain |
