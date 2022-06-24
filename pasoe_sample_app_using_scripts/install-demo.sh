#!/bin/bash

SCRIPTS=`dirname $0`

if [ "$S3_BUCKET" != "" ]
then
  ./aws_copy_files.sh
fi

if [ "$WEBFILES" != "" ]
then
  ./webfiles_copy_files.sh
fi

$SCRIPTS/install-podman.sh
$SCRIPTS/install-openedge.sh
$SCRIPTS/load-containers.sh
$SCRIPTS/install-pasoe-sample-app.sh
$SCRIPTS/run-pasoe-sample-app.sh
