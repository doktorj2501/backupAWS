#crontab: 
#00 00 * * 2-6   /home/ec2-user/backupAWS/backup.sh &> /home/ec2-user/backup/backup.log

#!/bin/bash
export PYTHONIOENCODING=utf8
iter=$(cat ~/backupAWS/iter)
obs_iter=$((iter-4))
iter_snid=$(cat ~/backup/json/name_sn_$obs_iter.json | python -c "import sys, json; print json.load(sys.stdin)['SnapshotId']");
aws ec2 delete-snapshot --snapshot-id $iter_snid;
rm ~/backup/json/jira_sn_$obs_iter.json;
current_date=$(date);
iter=$((iter+1))
aws ec2 create-snapshot --volume-id vol-ID --description "Name backup $current_date" > ~/backupAWS/json/name_sn_$iter.json;
echo "$iter" > ~/backupAWS/iter;

