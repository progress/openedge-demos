#!/bin/bash

NAME=pas.tar.gz
REPO=openedge-demos
API_URL=https://api.github.com/repos/progress/${REPO}/releases

LATEST_VERSION=`curl -s ${API_URL}/latest | jq -r ".name"`
URL=`curl -s ${API_URL}/tags/${LATEST_VERSION} | jq -r ".assets[] | select(.content_type == \"application/x-gzip\") | select(.name | contains(\"${NAME}\")) | .browser_download_url"`

mkdir -p /install
cd /install
wget $URL
tar xzvf $NAME

OE_ENV=pasoe DBHostName=HOST /install/app/deploy.sh 
