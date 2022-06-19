data "aws_caller_identity" "current" {
}

data "aws_iam_policy_document" "cmk_key_policy" {
  statement {
    sid = "1"

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::750285159662:root"
      ]
    }

    actions = [
      "kms:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_kms_key" "key" {
  description             = var.description
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = data.aws_iam_policy_document.cmk_key_policy.json
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = true
  enable_key_rotation     = true

  tags = merge(
    {
      Description   = var.description
      Environment   = var.environment
      Name          = var.alias_name
      ManagedBy     = "terraform"
    },
    var.additional_tags,
  )
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.key.id
}

output "cmk_arn" {
  description = "The ARN of the CMK"
  value       = aws_kms_key.key.arn
}
