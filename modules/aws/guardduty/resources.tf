resource "aws_guardduty_detector" "default" {
  enable = true
}

resource "aws_iam_role" "guardduty_malware" {
  name = var.malware_protection_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "malware-protection-plan.guardduty.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "guardduty_malware" {
  role = aws_iam_role.guardduty_malware.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [var.s3_bucket_arn, "${var.s3_bucket_arn}/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObjectTagging",
          "s3:GetObjectTagging"
        ]
        Resource = ["${var.s3_bucket_arn}/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketNotification",
          "s3:PutBucketNotification"
        ]
        Resource = [var.s3_bucket_arn]
      },
      {
        Effect = "Allow"
        Action = [
          "events:PutRule",
          "events:PutTargets",
          "events:DescribeRule",
          "events:ListTargetsByRule"
        ]
        resource = "arn:aws:events:*:*:rule/DO-NOT-DELETE-AmazonGuardDuty*"
      }
    ]
  })
}

resource "aws_guardduty_malware_protection_plan" "default" {
  role = aws_iam_role.guardduty_malware.arn

  protected_resource {
    s3_bucket {
      bucket_name = var.s3_bucket_name
    }
  }

  actions {
    tagging {
      status = "ENABLED"
    }
  }

  depends_on = [aws_guardduty_detector.default]
}
