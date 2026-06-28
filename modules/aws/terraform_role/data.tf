data "aws_iam_policy_document" "terraform_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        var.oidc_provider_arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"

      values = [
        "aws.workload.identity"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"

      values = [
        "organization:${var.organization}:project:${var.project}:workspace:${var.workspace}:run_phase:${var.run_phase}"
      ]
    }
  }
}
