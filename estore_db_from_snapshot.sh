!#/bin/sh

# Script will copy snapshot from shared snapshot and from there it will restore the DB.

aws rds describe-db-snapshots --region us-east-2 --include-shared --db-snapshot-identifier arn:aws:rds:us-east-2:462483370869:snapshot:mytfsnap

aws rds copy-db-snapshot --source-db-snapshot-identifier arn:aws:rds:us-east-2:462483370869:snapshot:mytfsnap --target-db-snapshot-identifier test123 --kms-key-id `aws kms list-keys | jq -r '.Keys[].KeyArn'`

echo "Checking DB Snapshot Status."
Status=`aws rds describe-db-snapshots --db-snapshot-identifier test123 | jq -r '.DBSnapshots[].Status'`

while [ ${Status} != "available" ]
do
	echo "DB Snapshot is not yet availble."
	sleep 30
	Status=`aws rds describe-db-snapshots --db-snapshot-identifier test123 | jq -r '.DBSnapshots[].Status'`
done

aws rds restore-db-instance-from-db-snapshot --db-instance-identifier RestoredDB --db-snapshot-identifier `aws rds describe-db-snapshots --db-snapshot-identifier test123 | jq -r '.DBSnapshots[].DBSnapshotArn'`
