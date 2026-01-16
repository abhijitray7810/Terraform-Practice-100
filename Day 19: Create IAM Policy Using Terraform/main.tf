resource "aws_iam_policy" "iampolicy_kareem" {
  name        = "iampolicy_kareem"
  description = "Read-only access to EC2 console - view instances, AMIs, and snapshots"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:GetConsole*",
          "ec2:GetPasswordData",
          "ec2:GetLaunchTemplateData",
          "ec2:GetReservedInstancesExchangeQuote",
          "ec2:GetCapacityReservationUsage",
          "ec2:GetEbsDefaultKmsKeyId",
          "ec2:GetEbsEncryptionByDefault",
          "ec2:GetHostReservationPurchasePreview",
          "ec2:GetManagedPrefixListAssociations",
          "ec2:GetManagedPrefixListEntries",
          "ec2:SearchTransitGatewayRoutes",
          "ec2:SearchLocalGatewayRoutes"
        ]
        Resource = "*"
      }
    ]
  })
}

output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = aws_iam_policy.iampolicy_kareem.arn
}

output "policy_name" {
  description = "Name of the created IAM policy"
  value       = aws_iam_policy.iampolicy_kareem.name
}
