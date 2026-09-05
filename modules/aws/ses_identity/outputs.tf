output "dkim_tokens" {
  description = "DKIM tokens used to create the SES DNS records."
  value       = aws_sesv2_email_identity.default.dkim_signing_attributes[0].tokens
}

output "verification_status" {
  description = "The current SES verification status."
  value       = aws_sesv2_email_identity.default.verification_status
}

output "arn" {
  description = "The ARN of the SES email identity."
  value       = aws_sesv2_email_identity.default.arn
}
