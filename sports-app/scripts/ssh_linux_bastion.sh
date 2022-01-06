#!/bin/bash

# aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,PrivateIP:PrivateIpAddress}" --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values='LinuxBastion'"

PUBLIC_IP_ADDRESS=`aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,PrivateIP:PrivateIpAddress}" --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values='LinuxBastion'" | jq -r '.[0][0].PublicIP'`

DB0=`aws ec2 describe-instances --query "Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values='db0'" | jq -r '.[0][0].PrivateIP'`
DB1=`aws ec2 describe-instances --query "Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values='db1'" | jq -r '.[0][0].PrivateIP'`
DB2=`aws ec2 describe-instances --query "Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values='db2'" | jq -r '.[0][0].PrivateIP'`
echo ssh -i sshkey.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@$DB0 > /tmp/ssh_db0.sh
echo ssh -i sshkey.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@$DB1 > /tmp/ssh_db1.sh
echo ssh -i sshkey.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@$DB2 > /tmp/ssh_db2.sh
chmod +x /tmp/ssh_db[0-2].sh
echo "Public Ip Address: $PUBLIC_IP_ADDRESS"
scp -i ~/environment/sshkey.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/environment/sshkey.pem ec2-user@$PUBLIC_IP_ADDRESS:/home/ec2-user
scp -i ~/environment/sshkey.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no /tmp/ssh_db0.sh /tmp/ssh_db1.sh /tmp/ssh_db2.sh ec2-user@$PUBLIC_IP_ADDRESS:/home/ec2-user
ssh -i ~/environment/sshkey.pem -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@$PUBLIC_IP_ADDRESS
