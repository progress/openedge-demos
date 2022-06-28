#!/bin/bash

WEBFILES="${WEBFILES:=WEBFILES_URL}"

mkdir -p ~/Downloads
cd ~/Downloads
for file in PROGRESS_OE_12.2.9_LNX_64.tar.gz PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.zip response.ini
do
  if [ ! -f ~/Downloads/$file ]
  then
    echo Downloading $file
    curl -sO ${WEBFILES}/$file
  fi
done
