# EC2 Instance Type Change using Terraform

## Overview
This project updates the instance type of an existing AWS EC2 instance named **datacenter-ec2** using Terraform. The instance type is changed from **t2.micro** to **t2.nano** to optimize resource utilization.

## Prerequisites
Before performing the change, ensure the following:

- Terraform is installed
- AWS CLI is configured with appropriate credentials
- The EC2 instance **datacenter-ec2** exists
- Instance **Status Checks** are completed (not in `initializing` state)

## Terraform Working Directory
```
/home/bob/terraform
```

## File Modified
```
main.tf
```

The EC2 instance resource configuration is updated to change the instance type.

### Example Configuration

```hcl
resource "aws_instance" "datacenter-ec2" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.nano"

  tags = {
    Name = "datacenter-ec2"
  }
}
```

## Steps Performed

### 1. Navigate to Terraform Directory
```bash
cd /home/bob/terraform
```

### 2. Verify EC2 Status Checks
Ensure both system and instance status checks are completed.

```bash
aws ec2 describe-instance-status --instance-ids <INSTANCE_ID>
```

Wait until:

```
InstanceStatus: ok
SystemStatus: ok
```

### 3. Update Terraform Configuration
Edit the **main.tf** file and change:

```
instance_type = "t2.micro"
```

to

```
instance_type = "t2.nano"
```

### 4. Initialize Terraform
```bash
terraform init
```

### 5. Review Planned Changes
```bash
terraform plan
```

Expected change:

```
~ instance_type = "t2.micro" -> "t2.nano"
```

### 6. Apply Terraform Changes
```bash
terraform apply
```

Confirm by typing:

```
yes
```

Terraform will automatically:
- Stop the instance
- Modify the instance type
- Restart the instance

### 7. Verify Instance State
Check that the instance is running.

```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=datacenter-ec2"
```

Expected state:

```
running
```

## Result
- Instance type successfully updated from **t2.micro** to **t2.nano**
- EC2 instance **datacenter-ec2** remains in **running** state
- Terraform configuration updated in **main.tf**

## Notes
- Do not create additional `.tf` files.
- Only modify the existing **main.tf** file.
- Ensure status checks are completed before applying changes.
