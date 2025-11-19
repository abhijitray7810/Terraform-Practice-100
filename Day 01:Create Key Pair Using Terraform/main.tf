provider "aws" {
  region = "us-east-1"
}

# Generate an RSA private key
resource "tls_private_key" "devops_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair using generated public key
resource "aws_key_pair" "devops_kp" {
  key_name   = "devops-kp"
  public_key = tls_private_key.devops_kp.public_key_openssh
}

# Save the private key locally
resource "local_file" "devops_private_key" {
  content              = tls_private_key.devops_kp.private_key_pem
  filename             = "/home/bob/devops-kp.pem"
  file_permission      = "0600"
  directory_permission = "0700"
}
