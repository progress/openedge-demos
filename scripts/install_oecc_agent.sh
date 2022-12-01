#!/bin/bash

# set -x

VERSION=1.2

if [ ! -d /usr/oecc_agent ]
then
  echo "Installing OpenEdge Command Center (Agent)..."
  sudo /files/PROGRESS_OECC_AGENT_${VERSION}.0_LNX_64.bin \
    -i silent \
    -f /vagrant/files/response_agent_${VERSION}.properties
fi

cp /vagrant/files/otagentoedb.yaml /usr/oecc_agent/conf
cp /vagrant/files/otagentpasoe.yaml /usr/oecc_agent/conf

sudo systemctl restart Progress-OpenEdge-Command-Center-Agent.service
