!#/bin/sh

# Script will copy DB snapshot of encrypted snapshot with CMK and then shared it with target account. 

aws rds  copy-db-snapshot --source-db-snapshot-identifier `terraform output  -json | jq -r '.db_snapshot_arn.value'` --target-db-snapshot-identifier myTFSnap  --source-region us-east-2 --kms-key-id `terraform output  -json | jq -r '.cmk_arn.value'`

echo "Checking DB Snapshot Status."
Status=`aws rds describe-db-snapshots --db-snapshot-identifier myTFSnap | jq -r '.DBSnapshots[].Status'`

while [ ${Status} != "available" ]
do
	echo "DB Snapshot is not yet availble."
	sleep 30
	Status=`aws rds describe-db-snapshots --db-snapshot-identifier myTFSnap | jq -r '.DBSnapshots[].Status'`
done

aws rds modify-db-snapshot-attribute --db-snapshot-identifier myTFSnap --attribute-name restore --values-to-add `terraform output  -json | jq -r '.target_account_id.value'`
