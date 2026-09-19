resource "aws_ses_receipt_rule_set" "default" {
  rule_set_name = "alextheman231"
}

resource "aws_ses_active_receipt_rule_set" "default" {
  rule_set_name = aws_ses_receipt_rule_set.default.rule_set_name
}
