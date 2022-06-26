#!/bin/bash

SCRIPTS=`dirname $0`

if [ "$S3_BUCKET" != "" ]
then
  $SCRIPTS/aws_copy_files.sh
fi

if [ "$WEBFILES" != "" ]
then
  $SCRIPTS/webfiles_copy_files.sh
fi

$SCRIPTS/install-podman.sh
$SCRIPTS/load-containers.sh
#
$SCRIPTS/install-openedge.sh
$SCRIPTS/install-pasoe-sample-app.sh
$SCRIPTS/run-pasoe-sample-app.sh
