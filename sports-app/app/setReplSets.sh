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

#DB1
cp /install/app/db/targetDB1.repl.properties sports2020.repl.properties
sed -i "s/DBHostName2/${DBHostName2}/" sports2020.repl.properties
sed -i "s/DBHostName1/${DBHostName1}/" sports2020.repl.properties
sed -i "s/DBHostName/${DBHostName}/" sports2020.repl.properties
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem sports2020.repl.properties ec2-user@${DBHostName1}:/psc/wrk/
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem /install/app/db/sports2020_backup_incremental ec2-user@${DBHostName1}:/install/app/db/
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName1} "chmod +x /install/app/setReplAgent.sh"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName1} /install/app/setReplAgent.sh

#DB2
cp /install/app/db/targetDB2.repl.properties sports2020.repl.properties
sed -i "s/DBHostName2/${DBHostName2}/" sports2020.repl.properties
sed -i "s/DBHostName1/${DBHostName1}/" sports2020.repl.properties
sed -i "s/DBHostName/${DBHostName}/" sports2020.repl.properties
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem sports2020.repl.properties ec2-user@${DBHostName2}:/psc/wrk/
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem /install/app/db/sports2020_backup_incremental ec2-user@${DBHostName2}:/install/app/db/
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName2} "chmod +x /install/app/setReplAgent.sh"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /install/app/sshkey.pem ec2-user@${DBHostName2} /install/app/setReplAgent.sh

cp /install/app/db/sourceDB.repl.properties sports2020.repl.properties
sed -i "s/DBHostName2/${DBHostName2}/" sports2020.repl.properties
sed -i "s/DBHostName1/${DBHostName1}/" sports2020.repl.properties
sed -i "s/DBHostName/${DBHostName}/" sports2020.repl.properties
proserve sports2020 -DBService replserv -S 20000 -aiarcdir aiArchives
