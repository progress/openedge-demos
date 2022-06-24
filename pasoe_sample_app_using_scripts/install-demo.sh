#!/bin/bash

if [ "$S3_BUCKET" != "" ]
then
  ./aws_copy_files.sh
fi

./install-podman.sh
./install-openedge.sh
./load-containers.sh
./install-pasoe-sample-app.sh
./run-pasoe-sample-app.sh
