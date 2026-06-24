terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.51.0"
    }
  }
}

data "aws_iam_policy_document" "github_assume_role" {
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
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.repository}:ref:refs/heads/main"
      ]
    }
  }
}



resource "aws_iam_role" "role" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

resource "aws_iam_role_policy" "role" {
  role   = aws_iam_role.role.id
  policy = var.policy_json
}

output "role_arn" {
  value = aws_iam_role.role.arn
}
