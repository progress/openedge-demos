#!/bin/bash

if [ ! -f /usr/lib/jvm/jdk/bin/java ]
then
  sudo mkdir -p /usr/lib/jvm/jdk/
  curl -sL https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.15%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.15_10.tar.gz | sudo tar xzvCf /usr/lib/jvm/jdk/ - --strip-components=1
else 
  echo JDK is already installed
  /usr/lib/jvm/jdk/bin/java --version
fi

if [ ! -d /psc/dlc/ ]
then
  mkdir /tmp/12.2.9/
  tar xzvCf /tmp/12.2.9/ ~/Downloads/PROGRESS_OE_12.2.9_LNX_64.tar.gz
  cd /tmp/
  sudo 12.2.9/proinst -b ~/Downloads/response.ini -l /tmp/install.log
  rm -rf /tmp/12.2.9/
else
  echo OpenEdge is already installed
  cat /psc/dlc/version
fi

