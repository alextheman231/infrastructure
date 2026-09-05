resource "aws_sesv2_email_identity" "default" {
  email_identity = var.domain_name
}
