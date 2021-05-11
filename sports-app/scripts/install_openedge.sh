#!/bin/bash

#sudo /install/12.2.0/proinst -b /install/12.2.0/response_oedev.ini -l /tmp/install.log

sudo mkdir /install
sudo chmod 777 /install
cd /install
aws s3 cp s3://mysupportfiles2/12.3.0.tar.gz .
tar xzvCf /install /install/12.3.0.tar.gz 
sudo ln -s /usr/lib/jvm/jre-openjdk /usr/lib/jvm/jdk
sudo rm /install/12.3.0.tar.gz 

sudo /install/12.3.0/proinst -b /install/12.3.0/response_oedev.ini -l /tmp/install.log && rm -rf /install/12.3.0
