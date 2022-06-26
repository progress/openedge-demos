#!/bin/bash

S3_BUCKET="${S3_BUCKET:=BUCKET_NAME}"

mkdir -p ~/Downloads
for file in PROGRESS_OE_12.2.9_LNX_64.tar.gz PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.zip response.ini
do
  echo Copying $file
  aws s3 cp s3://${S3_BUCKET}/$file ~/Downloads
done

mkdir -p ~/Downloads/containers
for file in adoptopenjdk.tar.gz alpine.tar.gz elasticsearch.tar.gz kibana.tar.gz nginx.tar.gz
do
  echo Copying $file
  aws s3 cp s3://${S3_BUCKET}/containers/$file ~/Downloads/containers
done
