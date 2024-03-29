#!/bin/bash

# set -x

if [ ! -f /usr/bin/docker ]
then
  sudo apt-get update
  sudo apt-get -y install \
       ca-certificates \
       curl \
       gnupg \
       lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $USER
fi

if [ ! -f /usr/local/bin/docker-compose ]
then
  sudo curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

