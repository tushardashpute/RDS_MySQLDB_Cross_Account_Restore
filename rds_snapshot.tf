resource "aws_db_snapshot" "test" {
  db_instance_identifier = var.db_instance
  db_snapshot_identifier = var.db_snapshot
}

resource "null_resource" "output-id" {
  provisioner "local-exec" {
      command = "sh -vx test.sh"
  }
  depends_on = [
     aws_db_snapshot.test
  ]
}
