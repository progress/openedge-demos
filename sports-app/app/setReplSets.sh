#!/bin/bash
# SetReplSets
#
set -x

echo $DBHostName1 >> /tmp/deploy1.txt
echo $DBHostName2 >> /tmp/deploy1.txt

export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH

cd /psc/wrk
mkdir -p aiArchives
prorest sports2020 /install/app/db/sports2020_backup
prostrct add sports2020 /install/app/db/addai.st
rfutil sports2020 -C aimage begin
rfutil sports2020 -C aiarchiver enable
proutil sports2020 -C enableSiteReplication source
probkup incremental sports2020 /install/app/db/sports2020_backup_incremental

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem /install/app/db/sports2020_backup_incremental ec2-user@${DBHostName1}:/install/app/db/
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem /install/app/db/sports2020_backup_incremental ec2-user@${DBHostName2}:/install/app/db/

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName1} "chmod +x /install/app/setReplAgent.sh"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName2} "chmod +x /install/app/setReplAgent.sh"

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName1} /install/app/setReplAgent.sh
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName2} /install/app/setReplAgent.sh

proserve sports2020 -DBService replserv -S 20000 -aiarcdir aiArchives
