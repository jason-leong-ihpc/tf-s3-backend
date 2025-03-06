# provider.tf

provider "aws" {
  region  = var.aws_region
  profile = "ihpc"
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}