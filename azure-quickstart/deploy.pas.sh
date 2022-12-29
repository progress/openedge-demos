#!/bin/bash

mkdir -p /install
cd /install
wget https://github.com/progress/openedge-demos/releases/download/v1.0.2/pas.tar.gz
tar xzvf pas.tar.gz

OE_ENV=pasoe DBHostName=$HOST /install/app/deploy.sh 
