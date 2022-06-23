#!/bin/bash

if [ ! -f /usr/bin/unzip ]
then
  sudo apt-get update
  sudo apt-get -y install unzip 
fi

if docker images store/progresssoftware/pasoe | fgrep pasoe > /dev/null
then
  echo PASOE image already loaded
  docker images store/progresssoftware/pasoe | fgrep pasoe
else
  mkdir /tmp/$$
  cd /tmp/$$
  unzip ~/Downloads/PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.zip
  docker load -i PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.tar.gz
  rm -rf /tmp/$$
fi

