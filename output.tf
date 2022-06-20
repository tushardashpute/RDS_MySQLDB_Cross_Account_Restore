output "target_account_id" {
  description = "Target Account ID"
  value       = var.target_account_id
}

output "cmk_arn" {
  description = "The ARN of the CMK"
  value       = aws_kms_key.key.arn
}

output "db_snapshot_arn" {
  description = "String. Name of the snapshot which a manual snapshot with custom CMK to be created."
  value       = aws_db_snapshot.test.db_snapshot_arn
}
