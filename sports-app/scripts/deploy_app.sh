#!/bin/bash

#aws s3 cp /install/app.tar.gz s3://mypublicfiles1/ --acl public-read

aws s3 cp /install/web.tar.gz s3://mypublicfiles1/ --acl public-read
aws s3 cp /install/pas.tar.gz s3://mypublicfiles1/ --acl public-read
aws s3 cp /install/db.tar.gz s3://mypublicfiles1/ --acl public-read
