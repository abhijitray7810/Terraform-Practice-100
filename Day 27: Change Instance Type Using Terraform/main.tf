# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.nano"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-0311a7b03e8a1dd1b"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}
