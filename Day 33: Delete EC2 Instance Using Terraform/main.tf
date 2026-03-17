# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-ad5cd4b1f7a65f0dc"
  ]

  tags = {
    Name = "nautilus-ec2"
  }
}
