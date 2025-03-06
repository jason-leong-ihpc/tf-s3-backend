# main.tf

locals {
  name_prefix = "ihpc-aws-poc"
}

# main.tf

# Create a KMS key for encrypting the S3 bucket
resource "aws_kms_key" "terraform_state" {
  description         = "KMS key for encrypting the Terraform state bucket"
  enable_key_rotation = true

  tags = {
    Name = "Terraform State Encryption Key"
  }

}

# Create an alias for the KMS key
resource "aws_kms_alias" "terraform_state_alias" {
  name          = "alias/terraform-state"
  target_key_id = aws_kms_key.terraform_state.id
}

# Create the S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${local.name_prefix}-s3"
  force_destroy = true

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
  }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Apply server-side encryption to the S3 bucket using KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.terraform_state.arn
    }
  }
}

# Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
  }
}
