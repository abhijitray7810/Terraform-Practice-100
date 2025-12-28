resource "aws_iam_user" "iamuser_kareem" {
  name = "iamuser_kareem"

  tags = {
    Name        = "iamuser_kareem"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
