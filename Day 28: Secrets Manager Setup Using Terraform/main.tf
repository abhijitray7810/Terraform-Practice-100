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

resource "aws_secretsmanager_secret" "nautilus_secret" {
  name = "nautilus-secret"
}

resource "aws_secretsmanager_secret_version" "nautilus_secret_version" {
  secret_id = aws_secretsmanager_secret.nautilus_secret.id

  secret_string = jsonencode({
    username = "admin"
    password = "Namin123"
  })
}

output "secret_arn" {
  value = aws_secretsmanager_secret.nautilus_secret.arn
}
