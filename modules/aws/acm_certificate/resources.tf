resource "aws_acm_certificate" "default" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}
