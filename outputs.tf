# outputs.tf

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "kms_key_arn" {
  description = "The ARN of the KMS key"
  value       = aws_kms_key.terraform_state.arn
}
