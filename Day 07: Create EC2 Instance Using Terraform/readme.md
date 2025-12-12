# Nautilus EC2 Instance Deployment

This Terraform configuration deploys an EC2 instance on AWS as part of the Nautilus DevOps team's infrastructure migration strategy.

## Overview

This project provisions a single EC2 instance with the following specifications:
- **Instance Name**: nautilus-ec2
- **AMI**: Amazon Linux (ami-0c101f26f147fa7fd)
- **Instance Type**: t2.micro
- **Key Pair**: nautilus-kp (RSA key, auto-generated)
- **Security Group**: Default VPC security group

## Prerequisites

Before you begin, ensure you have the following:

1. **Terraform installed** (version 1.0 or higher)
   ```bash
   terraform --version
   ```

2. **AWS CLI configured** with valid credentials
   ```bash
   aws configure
   ```
   You'll need:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region (should match your AMI region, typically us-east-1)

3. **Appropriate AWS permissions** to create:
   - EC2 instances
   - Key pairs
   - Access to default VPC and security groups

## Project Structure

```
/home/bob/terraform/
├── main.tf           # Main Terraform configuration
├── README.md         # This file
└── nautilus-kp.pem   # Private key (generated after apply)
```

## Deployment Steps

### 1. Navigate to the Terraform Directory

```bash
cd /home/bob/terraform
```

### 2. Initialize Terraform

This downloads the required provider plugins:

```bash
terraform init
```

Expected output:
```
Initializing the backend...
Initializing provider plugins...
Terraform has been successfully initialized!
```

### 3. Validate the Configuration

Check for syntax errors:

```bash
terraform validate
```

### 4. Preview the Changes

Review what Terraform will create:

```bash
terraform plan
```

This shows you all resources that will be created without actually creating them.

### 5. Apply the Configuration

Create the infrastructure:

```bash
terraform apply
```

Review the planned changes and type `yes` when prompted to confirm.

### 6. Verify Deployment

After successful deployment, Terraform will output:
- Instance ID
- Public IP address
- Private key file path

Example output:
```
instance_id = "i-0123456789abcdef0"
instance_public_ip = "54.123.45.67"
private_key_path = "/home/bob/terraform/nautilus-kp.pem"
```

## Connecting to Your Instance

### SSH Access

Use the generated private key to connect:

```bash
ssh -i nautilus-kp.pem ec2-user@<instance_public_ip>
```

Replace `<instance_public_ip>` with the actual IP from the Terraform output.

**Note**: If you get a "permissions too open" error, the file permissions should already be set correctly (0400), but you can verify with:

```bash
chmod 400 nautilus-kp.pem
```

## Managing Your Infrastructure

### View Current State

```bash
terraform show
```

### List Resources

```bash
terraform state list
```

### Destroy Infrastructure

When you need to tear down the resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm deletion.

## Troubleshooting

### Issue: "No valid credential sources found"

**Solution**: Configure AWS credentials:
```bash
aws configure
```

### Issue: AMI not found in region

**Solution**: Ensure you're using the correct AWS region (us-east-1) or update the AMI ID for your region.

### Issue: "default VPC not found"

**Solution**: Create a default VPC in your AWS account:
```bash
aws ec2 create-default-vpc
```

### Issue: Cannot connect via SSH

**Solution**: 
1. Verify the security group allows SSH (port 22) from your IP
2. Check that the instance is in "running" state
3. Verify you're using the correct username (`ec2-user` for Amazon Linux)

## Configuration Details

### Resources Created

1. **TLS Private Key**: Generates a 4096-bit RSA key pair
2. **AWS Key Pair**: Registers the public key with AWS
3. **Local File**: Saves the private key locally with secure permissions
4. **EC2 Instance**: Launches the t2.micro instance with specified configuration

### Data Sources Used

- **Default VPC**: Automatically discovers your default VPC
- **Default Security Group**: Fetches the default security group from the VPC

## Security Considerations

- The private key file (`nautilus-kp.pem`) is created with restrictive permissions (0400)
- **Never commit the private key to version control**
- Add `*.pem` to your `.gitignore` file if using Git
- Consider using AWS Systems Manager Session Manager for secure access without SSH keys

## Cost Considerations

- **t2.micro** instances are eligible for the AWS Free Tier (750 hours/month for 12 months)
- Additional charges may apply for data transfer and EBS storage
- Remember to destroy resources when not in use to avoid unnecessary costs

## Next Steps

After deployment, consider:

1. Installing required software on the instance
2. Configuring additional security groups for specific access rules
3. Setting up monitoring and alerts via CloudWatch
4. Implementing backup strategies with AMIs or snapshots
5. Scaling the infrastructure as needed for the Nautilus migration

## Support

For issues or questions:
- Review Terraform documentation: https://www.terraform.io/docs
- Check AWS EC2 documentation: https://docs.aws.amazon.com/ec2
- Contact the Nautilus DevOps team

## Version History

- **v1.0** - Initial EC2 instance deployment configuration

---

**Project**: Nautilus Infrastructure Migration  
**Team**: DevOps  
**Last Updated**: December 2025
