module "aws" {
  source = "./aws"
}

moved {
  from = aws_guardduty_detector.default
  to   = module.aws.aws_guardduty_detector.default
}

moved {
  from = module.aws_network
  to   = module.aws.module.network
}

moved {
  from = aws_ses_receipt_rule_set.default
  to   = module.aws.aws_ses_receipt_rule_set.default
}

moved {
  from = aws_ses_active_receipt_rule_set.default
  to   = module.aws.aws_ses_active_receipt_rule_set.default
}


moved {
  from = module.alex_iam_user
  to   = module.aws.module.alex_iam_user
}

moved {
  from = module.alex_iam_read_only_user
  to   = module.aws.module.alex_iam_read_only_user
}
