#!/bin/bash

SCRIPTS=`dirname $0`
CONTAINER_ENGINE="${1:-podman}"

if [ "$S3_BUCKET" != "" ]
then
  $SCRIPTS/aws_copy_files.sh
fi

if [ "$WEBFILES" != "" ]
then
  $SCRIPTS/webfiles_copy_files.sh
fi

if [ "$CONTAINER_ENGINE" == "docker" ]
then
  $SCRIPTS/install-docker.sh
fi

if [ "$CONTAINER_ENGINE" == "podman" ]
then
  $SCRIPTS/install-podman.sh
fi

$SCRIPTS/install-podman.sh
$SCRIPTS/load-containers.sh
#
$SCRIPTS/install-openedge.sh
$SCRIPTS/install-pasoe-sample-app.sh

if [ "$CONTAINER_ENGINE" == "docker" ]
then
  newgrp docker << EOT
$SCRIPTS/run-pasoe-sample-app.sh
EOT
else
  $SCRIPTS/run-pasoe-sample-app.sh
fi
