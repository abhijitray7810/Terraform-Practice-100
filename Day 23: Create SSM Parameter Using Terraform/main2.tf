resource "aws_ssm_parameter" "datacenter_parameter" {
  name  = "datacenter-ssm-parameter"
  type  = "String"
  value = "datacenter-value"

  tags = {
    Name        = "datacenter-ssm-parameter"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

output "parameter_name" {
  description = "The name of the SSM parameter"
  value       = aws_ssm_parameter.datacenter_parameter.name
}

output "parameter_type" {
  description = "The type of the SSM parameter"
  value       = aws_ssm_parameter.datacenter_parameter.type
}

output "parameter_value" {
  description = "The value of the SSM parameter"
  value       = aws_ssm_parameter.datacenter_parameter.value
  sensitive   = true
}

output "parameter_arn" {
  description = "The ARN of the SSM parameter"
  value       = aws_ssm_parameter.datacenter_parameter.arn
}
