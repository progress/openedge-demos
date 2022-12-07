#!/bin/bash

# set -x
DEMO=${DEMO-/vagrant}
VERSION=1.2

if [ ! -d /usr/oecc_agent ]
then
  echo "Installing OpenEdge Command Center Agent..."
  sudo chmod +x /files/PROGRESS_OECC_AGENT_${VERSION}.0_LNX_64.bin
  sudo /files/PROGRESS_OECC_AGENT_${VERSION}.0_LNX_64.bin \
    -i silent \
    -f $DEMO/files/response_agent_${VERSION}.properties
fi

cp /files/otagentoedb.yaml /usr/oecc_agent/conf
cp /files/otagentpasoe.yaml /usr/oecc_agent/conf

sudo systemctl restart Progress-OpenEdge-Command-Center-Agent.service
