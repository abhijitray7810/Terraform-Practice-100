resource "aws_iam_policy" "nautilus_policy" {
  name        = var.KKE_iampolicy
  description = "Terraform-managed IAM policy for Nautilus"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
