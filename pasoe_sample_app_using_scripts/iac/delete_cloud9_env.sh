#!/bin/bash

# set -x
ENVIRONMENTS=`aws cloud9 list-environments | jq -r .environmentIds[]`
ENV_ID=`aws cloud9 describe-environments --environment-ids ${ENVIRONMENTS} | jq -r '.environments[] | select(.name =="test-pasoe-container") | .id'`

echo $ENV_ID

aws cloud9 delete-environment --environment-id $ENV_ID
