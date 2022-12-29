#!/bin/bash

mkdir -p /install
cd /install
wget https://github.com/progress/openedge-demos/releases/download/v1.0.2/db.tar.gz
tar xzvf db.tar.gz

OE_ENV=db0 /install/app/deploy.sh 
