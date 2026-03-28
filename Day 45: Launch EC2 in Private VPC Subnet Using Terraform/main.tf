provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "datacenter_priv_vpc" {
  cidr_block = var.KKE_VPC_CIDR

  tags = {
    Name = "datacenter-priv-vpc"
  }
}

# Subnet (NO auto-assign public IP)
resource "aws_subnet" "datacenter_priv_subnet" {
  vpc_id                  = aws_vpc.datacenter_priv_vpc.id
  cidr_block              = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false

  tags = {
    Name = "datacenter-priv-subnet"
  }
}

# Security Group (allow only VPC internal traffic)
resource "aws_security_group" "datacenter_priv_sg" {
  name        = "datacenter-priv-sg"
  description = "Allow traffic only within VPC"
  vpc_id      = aws_vpc.datacenter_priv_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  tags = {
    Name = "datacenter-priv-sg"
  }
}

# EC2 Instance
resource "aws_instance" "datacenter_priv_ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (example, update if needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.datacenter_priv_subnet.id

  vpc_security_group_ids = [aws_security_group.datacenter_priv_sg.id]

  associate_public_ip_address = false

  tags = {
    Name = "datacenter-priv-ec2"
  }
}
