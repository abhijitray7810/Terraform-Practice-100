provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "nautilus_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.KKE_vpc
  }
}
