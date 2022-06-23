#!/bin/bash

if [ ! -f /usr/bin/unzip ]
then
  sudo apt-get update
  sudo apt-get -y install unzip 
fi

if [ ! -d ~/pasoe-sample-app/ ]
then
  cd /tmp/
  curl -sL https://community.progress.com/sfc/servlet.shepherd/document/download/0694Q00000AoPwiQAF?operationContext=S1 -o /tmp/SampleApp_12.2.3.zip

  mkdir -p ~/pasoe-sample-app/
  cd ~/pasoe-sample-app/
  unzip /tmp/SampleApp_12.2.3.zip
  unzip ~/Downloads/PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.zip deploy/*

  rm /tmp/SampleApp_12.2.3.zip 
else
  echo PASOE Sample App is already installed
  fgrep Environment ~/pasoe-sample-app/README.md
fi


