#!/bin/bash

sudo apt-get update
sudo apt-get -y install nginx

mkdir -p /install
cd /install
wget https://github.com/progress/openedge-demos/releases/download/v1.0.2/web.tar.gz
tar xzvf web.tar.gz
OE_ENV=webserver PASOEURL=http://$HOST:$PORT /install/app/deploy.sh
