resource "aws_ses_receipt_rule" "default" {
  name          = var.name
  rule_set_name = var.rule_set_name
  recipients    = var.recipients
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name = var.s3_bucket_name
    position    = var.position
  }
}

resource "aws_s3_bucket_policy" "email" {
  bucket = var.s3_bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSESPuts"
        Effect = "Allow"
        Principal = {
          Service = "ses.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
        Condition = {
          StringEquals = {
            "aws:Referer" = var.ses_account_id
          }
        }
      }
    ]
  })
}
