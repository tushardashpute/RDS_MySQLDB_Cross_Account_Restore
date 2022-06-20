resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "AWS": "arn:aws:iam::${var.target_account_id}:root"
        }
      },
    ]
  })

  tags = {
    tag-key = var.tag
  }
}

  resource "aws_iam_role_policy_attachment" "test-attach" {
    for_each = toset([
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
   ]) 
 
   role       = aws_iam_role.test_role.name
   policy_arn = each.value
}
