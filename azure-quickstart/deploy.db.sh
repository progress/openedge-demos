#!/bin/bash

mkdir -p /install
cd /install

# Example: https://github.com/progress/openedge-demos/releases/download/v1.0.2/db.tar.gz
wget -O db.tar.gz $DEPLOYMENT_PACKAGE
tar xzvf db.tar.gz

OE_ENV=db0 /install/app/deploy.sh 
