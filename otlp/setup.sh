#!/bin/bash

if [ "$EUID" -ne "0" ]
then
  echo "Usage: sudo ./setup.sh"
  echo "Program must be as root user"
  exit 1
fi

export DEMO=`pwd`

FILE=PROGRESS_OE_12.6_LNX_64.tar.gz
if [ ! -f /files/$FILE ]
then
  echo "Prerequisite: OpenEdge 12.6 media ($FILE) must be found in /files folder."
  exit
fi

FILE=response_12.6.ini
if [ ! -f /files/$FILE ]
then
  echo "Prerequisite: OpenEdge 12.6 response.ini file ($FILE) must be found in /files folder."
  exit
fi

FILE=PROGRESS_OECC_SERVER_1.2.0_LNX_64.tar.gz
if [ ! -f /files/$FILE ]
then
  echo "Prerequisite: OpenEdge Command Center Server 1.2 .tar.gz file ($FILE) must be found in /files folder."
  exit
fi

FILE=PROGRESS_OECC_AGENT_1.2.0_LNX_64.bin
if [ ! -f /files/$FILE ]
then
  echo "Prerequisite: OpenEdge Command Center Agent 1.2 .bin file ($FILE) must be found in /files folder."
  exit
fi

if [ ! -f /usr/bin/jq ]
then
  apt-get update
  apt-get install -y jq
fi

if sudo dmidecode -s bios-version | fgrep -qi amazon
then
  PRIVATE_IP_ADDRESS=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
else
  if sudo dmidecode -s system-manufacturer | fgrep -q "Microsoft Corporation"
  then
    PRIVATE_IP_ADDRESS=`curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq -r '.network.interface[0].ipv4.ipAddress[0].privateIpAddress'`
  fi
fi

if [ ! -f docker/oecc/PROGRESS_OECC_SERVER_1.2.0_LNX_64.tar.gz ]
then
  cp /files/PROGRESS_OECC_SERVER_1.2.0_LNX_64.tar.gz docker/oecc
fi

for file in openedge.properties otagentoedb.yaml otagentpasoe.yaml
do
  cp files/$file /files
  if [ "${PRIVATE_IP_ADDRESS}" != "" ]
  then
    sed -i "s/192.168.56.215/${PRIVATE_IP_ADDRESS}/g" /files/$file
  fi
done

if [ ! -f /etc/rc.local ]
then
  cp files/rc.local /etc/rc.local
  chmod +x /etc/rc.local
fi    

chmod +x ../scripts/*.sh

echo Running install_docker.sh...
../scripts/install_docker.sh
echo Running install_docker_compose.sh...
../scripts/install_docker_compose.sh
echo Running install_openjdk.sh...
../scripts/install_openjdk.sh 17
echo Running install_openedge.sh...
../scripts/install_openedge.sh 12.6
echo Running create_sports2020.sh...
../scripts/create_sports2020.sh
echo Running create_oepas1.sh...
../scripts/create_oepas1.sh

echo Running docker-compose up -d...
../scripts/create_oepas1.sh
cd docker
docker-compose up -d 
cd ..

echo Running upload_agentkey.sh...
../scripts/upload_agentkey.sh
echo Running install_oecc_agent.sh...
../scripts/install_oecc_agent.sh
