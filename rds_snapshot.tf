resource "aws_db_snapshot" "test" {
  db_instance_identifier = "sourcerds"
  db_snapshot_identifier = "testsnapshot1234"
}

output "db_snapshot_arn" {
  description = "String. Name of the snapshot which a manual snapshot with custom CMK to be created."
  value       = aws_db_snapshot.test.db_snapshot_arn
}

resource "null_resource" "output-id" {
  provisioner "local-exec" {
      command = "sh -vx test.sh"
  }
  depends_on = ["aws_db_snapshot.test"]
}
