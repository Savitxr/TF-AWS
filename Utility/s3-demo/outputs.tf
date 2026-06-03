output "bucket_name" {
  description = "The globally unique name of the created S3 bucket."
  value       = aws_s3_bucket.demo.id
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket."
  value       = aws_s3_bucket.demo.arn
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the created S3 bucket."
  value       = aws_s3_bucket.demo.bucket_regional_domain_name
}
