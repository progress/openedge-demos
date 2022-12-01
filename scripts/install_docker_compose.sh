#!/bin/bash
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

# set -x

BASE_URL=https://github.com/docker/compose/releases/download
VERSION=1.29.2
if [ ! -f /usr/local/bin/docker-compose ]
then
  echo "Installing Docker Compose..."
  sudo curl \
         -s \
         -L "${BASE_URL}/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
         -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

