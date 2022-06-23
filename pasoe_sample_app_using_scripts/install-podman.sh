#!/bin/bash

if [ ! -f /usr/bin/podman ]
then
  sudo apt-get update
  sudo apt-get -y install podman podman-docker
fi

if [ ! -f /usr/local/bin/docker-compose ]
then
  sudo curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

# Create podman.socket for regular user
systemctl enable --now --user podman.socket

# export DOCKER_HOST="unix:$XDG_RUNTIME_DIR/podman/podman.sock"
