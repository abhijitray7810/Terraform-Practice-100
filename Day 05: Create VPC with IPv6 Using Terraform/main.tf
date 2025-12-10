# Create VPC with Amazon-provided IPv6 CIDR block
resource "aws_vpc" "datacenter_vpc" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  
  tags = {
    Name = "datacenter-vpc"
  }
}

# Output the VPC details
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.datacenter_vpc.id
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block of the VPC"
  value       = aws_vpc.datacenter_vpc.ipv6_cidr_block
}

output "vpc_cidr_block" {
  description = "The IPv4 CIDR block of the VPC"
  value       = aws_vpc.datacenter_vpc.cidr_block
}
