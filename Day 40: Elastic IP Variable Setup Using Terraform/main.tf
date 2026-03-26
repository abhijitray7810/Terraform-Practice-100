resource "aws_eip" "nautilus_eip" {
  tags = {
    Name = var.KKE_eip
  }
}
