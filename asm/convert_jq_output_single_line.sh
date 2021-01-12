aws rds describe-db-instances | jq '.DBInstances[] | {DBInstanceIdentifier,AllocatedStorage}' |jq -c .
