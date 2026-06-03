# Generate a random pet name to ensure the S3 bucket name is globally unique
resource "random_pet" "suffix" {
  length    = 2
  separator = "-"
}

# 1. S3 Bucket
resource "aws_s3_bucket" "demo" {
  bucket        = "${var.bucket_prefix}-${random_pet.suffix.id}"
  force_destroy = true # Allows destroying bucket via terraform destroy even if it contains objects (useful for demos)

  tags = {
    Name = "demo-s3-bucket"
  }
}

# 2. S3 Bucket Versioning Configuration
resource "aws_s3_bucket_versioning" "demo_versioning" {
  bucket = aws_s3_bucket.demo.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. S3 Bucket Server-Side Encryption Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "demo_encryption" {
  bucket = aws_s3_bucket.demo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4. S3 Bucket Public Access Block (Secure by Default)
resource "aws_s3_bucket_public_access_block" "demo_public_access" {
  bucket = aws_s3_bucket.demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
