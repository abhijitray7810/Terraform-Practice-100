# Allocate Elastic IP
resource "aws_eip" "xfusion_eip" {
  domain = "vpc"

  tags = {
    Name = "xfusion-eip"
  }
}

# Output the allocated Elastic IP address
output "elastic_ip" {
  description = "The allocated Elastic IP address"
  value       = aws_eip.xfusion_eip.public_ip
}

output "allocation_id" {
  description = "The allocation ID of the Elastic IP"
  value       = aws_eip.xfusion_eip.id
}
