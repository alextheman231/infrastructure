resource "aws_s3_bucket" "default" {
  bucket = var.name
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.default.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.default.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "default" {
  bucket = aws_s3_bucket.default.id
  count  = var.auto_delete_after_days > 0 ? 1 : 0

  rule {
    id     = "auto_expiration"
    status = "Enabled"

    expiration {
      days = var.auto_delete_after_days
    }

    filter {}
  }
}
