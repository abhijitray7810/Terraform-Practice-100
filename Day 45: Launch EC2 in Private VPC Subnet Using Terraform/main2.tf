provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "xfusion_priv_vpc" {
  cidr_block = var.KKE_VPC_CIDR

  tags = {
    Name = "xfusion-priv-vpc"
  }
}

# Subnet (private, no auto public IP)
resource "aws_subnet" "xfusion_priv_subnet" {
  vpc_id                  = aws_vpc.xfusion_priv_vpc.id
  cidr_block              = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false

  tags = {
    Name = "xfusion-priv-subnet"
  }
}

# Security Group (only allow VPC internal traffic)
resource "aws_security_group" "xfusion_priv_sg" {
  name   = "xfusion-priv-sg"
  vpc_id = aws_vpc.xfusion_priv_vpc.id

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
    Name = "xfusion-priv-sg"
  }
}

# EC2 Instance (private)
resource "aws_instance" "xfusion_priv_ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # update if region differs
  instance_type = "t2.micro"

  subnet_id = aws_subnet.xfusion_priv_subnet.id

  vpc_security_group_ids      = [aws_security_group.xfusion_priv_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "xfusion-priv-ec2"
  }
}
