# RDS_MySQLDB_Cross_Account_Restore

Steps:
======
1. On source account create role having sts policy for Target account (To create and share snapshot from source to target account).
2. Create CMK in source account, and share it with Target account.
3. Create inline policy in source account and assign it to role to have permission on Source account CMK
4. Create snapshot of RDS MySQL DB with the newly created CMK and share it with target account.
5. Create snapshot in target account from the shared snapshot.
6. Restore the DB from snapshot in target account.

Have added Terrafrom scripts and one shell script (restore_DB_from_snapshot.sh).

Note: If we want to share the DB snapshot across region or different account, we need to encrpyt it with CMK and give access on it to target account.

Terrafrom script will be run on source account. It will do floowing things :
 - Create IAM role
 - Create CMK and shared it with target account.
 - Create DB snapshot with the default DB KMS key
 - Copy DB snapshot from above snapshot with CMK and share it with Target Account.(Script test.sh will do that)

On Target account run the restore_DB_from_snapshot.sh script. 
