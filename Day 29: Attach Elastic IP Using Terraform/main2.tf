# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-dbf0bdffc622f1949"
  vpc_security_group_ids = [
    "sg-5a54715ea1bef85fd"
  ]

  tags = {
    Name = "devops-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  tags = {
    Name = "devops-ec2-eip"
  }
}

# Attach Elastic IP to EC2
resource "aws_eip_association" "devops_ec2_eip_attach" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2_eip.id
}
