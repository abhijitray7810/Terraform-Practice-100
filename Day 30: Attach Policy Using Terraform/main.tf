# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_john"

  tags = {
    Name = "iamuser_john"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_john"
  description = "IAM policy allowing EC2 read actions for john"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}

# Attach IAM policy to IAM user
resource "aws_iam_user_policy_attachment" "john_policy_attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
