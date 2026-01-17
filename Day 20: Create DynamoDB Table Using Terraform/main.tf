terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "datacenter_users" {
  name           = "datacenter-users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "datacenter_id"

  attribute {
    name = "datacenter_id"
    type = "S"
  }

  tags = {
    Name        = "datacenter-users"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

output "table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.datacenter_users.name
}

output "table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.datacenter_users.arn
}
