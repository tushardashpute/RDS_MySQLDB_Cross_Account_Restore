aws rds  copy-db-snapshot --source-db-snapshot-identifier `terraform output  -json | jq -r '.db_snapshot_arn.value'` --target-db-snapshot-identifier myTFSnap  --source-region us-east-2 --kms-key-id `terraform output  -json | jq -r '.cmk_arn.value'`
aws rds modify-db-snapshot-attribute --db-snapshot-identifier myTFSnap --attribute-name restore --values-to-add  750285159662
