# Nautilus EBS Volume Snapshot

This Terraform configuration creates an automated snapshot of the `nautilus-vol` EBS volume in the `us-east-1` region.

## Overview

The configuration performs the following tasks:
- Locates the existing EBS volume named `nautilus-vol`
- Creates a snapshot with the name `nautilus-vol-ss`
- Adds the description "Nautilus Snapshot"
- Waits for the snapshot to reach `completed` status

## Prerequisites

- Terraform installed (version 1.0 or higher recommended)
- AWS CLI configured with appropriate credentials
- Existing EBS volume named `nautilus-vol` in `us-east-1` region
- IAM permissions for:
  - `ec2:DescribeVolumes`
  - `ec2:CreateSnapshot`
  - `ec2:DescribeSnapshots`
  - `ec2:CreateTags`

## Configuration Files

- `main.tf` - Main Terraform configuration file containing:
  - AWS provider configuration
  - Data source to fetch the existing volume
  - EBS snapshot resource
  - Output values for verification

## Usage

### 1. Initialize Terraform

```bash
cd /home/bob/terraform
terraform init
```

This downloads the required AWS provider plugins.

### 2. Preview Changes

```bash
terraform plan
```

Review the execution plan to ensure it will create the snapshot correctly.

### 3. Apply Configuration

```bash
terraform apply
```

Or to auto-approve:

```bash
terraform apply -auto-approve
```

Terraform will create the snapshot and wait for it to complete before finishing.

### 4. Verify Snapshot Status

Check the outputs:

```bash
terraform output
```

Verify snapshot status using AWS CLI:

```bash
SNAPSHOT_ID=$(terraform output -raw snapshot_id)
aws ec2 describe-snapshots --snapshot-ids $SNAPSHOT_ID --region us-east-1 --query 'Snapshots[0].State' --output text
```

Expected output: `completed`

## Outputs

The configuration provides the following outputs:

- **snapshot_id**: The unique ID of the created snapshot
- **snapshot_arn**: The ARN of the snapshot
- **volume_id**: The ID of the source volume

## Resource Details

### EBS Snapshot Resource

```hcl
resource "aws_ebs_snapshot" "nautilus_snapshot"
```

**Properties:**
- Name: `nautilus-vol-ss`
- Description: `Nautilus Snapshot`
- Region: `us-east-1`
- Source Volume: `nautilus-vol`

## Cleanup

To remove the snapshot (if needed):

```bash
terraform destroy
```

**Warning**: This will permanently delete the snapshot. Ensure you have backups if needed.

## Troubleshooting

### Volume Not Found

If you receive an error that the volume cannot be found:

```bash
# List all volumes in us-east-1
aws ec2 describe-volumes --region us-east-1 --filters "Name=tag:Name,Values=nautilus-vol"
```

Ensure the volume has a tag with key `Name` and value `nautilus-vol`.

### Permission Denied

Verify your AWS credentials have the necessary IAM permissions:

```bash
aws sts get-caller-identity
```

### Snapshot Taking Too Long

EBS snapshots are incremental and can take time depending on volume size and data changes. The first snapshot of a volume takes longer than subsequent snapshots.

## Notes

- The `aws_ebs_snapshot` resource automatically waits for the snapshot to reach `completed` state
- Snapshots are incremental - only changed blocks are stored
- Snapshot creation does not interrupt volume operations
- Snapshots can be used to create new volumes or restore existing ones

## Support

For issues related to this configuration, contact the Nautilus DevOps team.
