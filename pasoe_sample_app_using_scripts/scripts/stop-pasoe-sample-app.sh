#!/bin/bash

export DLC=/psc/dlc
export PATH=$PATH:$DLC/bin
export DOCKER_HOST="unix:$XDG_RUNTIME_DIR/podman/podman.sock"

cd ~/pasoe-sample-app/
proant -f deploy/build.xml undeploy

docker-compose down

