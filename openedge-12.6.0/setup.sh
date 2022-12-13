#!/bin/bash

if [ ! -f /usr/bin/jq ]
then
  apt-get update
  apt-get install -y jq
fi

chmod +rx ../scripts/*.sh
echo Running install_openjdk.sh...
../scripts/install_openjdk.sh 17
echo Running install_openedge.sh...
../scripts/install_openedge.sh 12.6
