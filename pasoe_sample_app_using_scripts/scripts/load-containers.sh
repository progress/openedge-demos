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
  cd
fi

# Load containers from Downloads/containers directory if it exists
if [ -d ~/Downloads/containers/ ]
then
  for file in ~/Downloads/containers/*
  do
    container_name=`basename $file | cut -d. -f1`
    if docker images | fgrep $container_name > /dev/null
    then
      echo $container_name image already loaded
      docker images | fgrep $container_name
    else
      echo Loading $container_name image
      docker load -i $file
    fi
  done
fi

# Load containers from WEBFILES location
if [ "$WEBFILES" != "" ]
then
  for container_name in adoptopenjdk alpine elasticsearch kibana nginx 
  do
    echo $container_name
    if docker images | fgrep $container_name > /dev/null
    then
      echo $container_name image already loaded
      docker images | fgrep $container_name
    else
      if curl --head --fail -so /dev/null $WEBFILES/containers/$container_name.tar.gz
      then
        echo Loading $container_name image
        curl -s $WEBFILES/containers/$container_name.tar.gz | docker load
      fi
    fi
  done
fi

# time curl --head --fail -so /dev/null $WEBFILES/containers/elasticsearch.tar.gz

