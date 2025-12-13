terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# -------------------------------------------------
# EC2 Instance
# -------------------------------------------------
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    "sg-4b78c5322a68d81f4"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}

# -------------------------------------------------
# Read EC2 Instance (by tag)
# -------------------------------------------------
data "aws_instance" "datacenter_ec2" {
  filter {
    name   = "tag:Name"
    values = ["datacenter-ec2"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running", "stopped"]
  }
}

# -------------------------------------------------
# Create AMI from EC2 Instance
# -------------------------------------------------
resource "aws_ami_from_instance" "datacenter_ec2_ami" {
  name               = "datacenter-ec2-ami"
  source_instance_id = data.aws_instance.datacenter_ec2.id

  tags = {
    Name = "datacenter-ec2-ami"
  }
}

# -------------------------------------------------
# Read AMI details (to get state)
# -------------------------------------------------
data "aws_ami" "datacenter_ec2_ami" {
  depends_on = [aws_ami_from_instance.datacenter_ec2_ami]

  owners      = ["self"]
  most_recent = true

  filter {
    name   = "image-id"
    values = [aws_ami_from_instance.datacenter_ec2_ami.id]
  }
}

# -------------------------------------------------
# Outputs
# -------------------------------------------------
output "ami_id" {
  description = "AMI ID"
  value       = aws_ami_from_instance.datacenter_ec2_ami.id
}

output "ami_name" {
  description = "AMI Name"
  value       = aws_ami_from_instance.datacenter_ec2_ami.name
}

output "ami_state" {
  description = "AMI State (pending / available)"
  value       = data.aws_ami.datacenter_ec2_ami.state
}
