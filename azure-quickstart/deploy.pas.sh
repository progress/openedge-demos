#!/bin/bash

mkdir -p /install
cd /install

# Example: https://github.com/progress/openedge-demos/releases/download/v1.0.2/pas.tar.gz
wget -O pas.tar.gz $DEPLOYMENT_PACKAGE
tar xzvf pas.tar.gz

OE_ENV=pasoe DBHostName=$HOST /install/app/deploy.sh 
