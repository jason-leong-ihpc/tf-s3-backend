# variables.tf

# variable "s3_bucket_name" {
#   description = "Name of the S3 bucket for Terraform state"
#   type        = string
#   default     = "ihpc-state-bucket"
# }

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-lock"
}

variable "environment" {
  description = "Deployment environment (e.g., Development, Production)"
  type        = string
  default     = "Development"
}
