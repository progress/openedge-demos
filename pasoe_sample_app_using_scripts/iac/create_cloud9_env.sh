#!/bin/bash

aws cloud9 create-environment-ec2 \
    --name test-pasoe-container \
    --instance-type t3.medium \
    --description "Environment to test PASOE container." \
    --image-id ubuntu-18.04-x86_64 \
    --owner-arn "${OWNER_ARN}"

