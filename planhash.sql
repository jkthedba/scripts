select plan_hash_value from v$sql ,v$SESSION where sql_hash_value=hash_value and hash_value=&hash_value
/
