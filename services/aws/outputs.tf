output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "receipt_rule_set_name" {
  value = aws_ses_active_receipt_rule_set.default.rule_set_name
}

output "guardduty_detector_id" {
  value = aws_guardduty_detector.default.id
}
