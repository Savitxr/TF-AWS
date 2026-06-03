variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the S3 bucket in."
  default     = "us-east-1"
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the S3 bucket name. A random suffix will be appended to ensure global uniqueness."
  default     = "demo-bucket"
}
