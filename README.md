# RDS_MySQLDB_Cross_Account_Restore

Steps:
======
1. On source account create role having sts policy for Target account (To create and share snapshot from source to target account).
2. Create CMK in source account, and share it with Target account.
3. Create inline policy in source account and assign it to role to have permission on Source account CMK
4. Create snapshot of RDS MySQL DB with the newly created CMK and share it with target account.
5. Create snapshot in target account from the shared snapshot.
6. Restore the DB from snapshot in target account.

