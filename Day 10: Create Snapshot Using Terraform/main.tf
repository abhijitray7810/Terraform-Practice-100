# Data source to fetch the existing volume
data "aws_ebs_volume" "nautilus_vol" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["nautilus-vol"]
  }
}

# Create the EBS snapshot
resource "aws_ebs_snapshot" "nautilus_snapshot" {
  volume_id   = data.aws_ebs_volume.nautilus_vol.id
  description = "Nautilus Snapshot"

  tags = {
    Name = "nautilus-vol-ss"
  }
}

# Output to verify the snapshot status
output "snapshot_id" {
  value       = aws_ebs_snapshot.nautilus_snapshot.id
  description = "The ID of the created snapshot"
}

output "snapshot_arn" {
  value       = aws_ebs_snapshot.nautilus_snapshot.arn
  description = "The ARN of the snapshot"
}

output "volume_id" {
  value       = data.aws_ebs_volume.nautilus_vol.id
  description = "The ID of the source volume"
}
