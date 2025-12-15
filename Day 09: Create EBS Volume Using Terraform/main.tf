resource "aws_ebs_volume" "datacenter_volume" {
  availability_zone = "us-east-1a"
  size              = 2
  type              = "gp3"

  tags = {
    Name = "datacenter-volume"
  }
}

output "volume_id" {
  description = "The ID of the EBS volume"
  value       = aws_ebs_volume.datacenter_volume.id
}

output "volume_arn" {
  description = "The ARN of the EBS volume"
  value       = aws_ebs_volume.datacenter_volume.arn
}
