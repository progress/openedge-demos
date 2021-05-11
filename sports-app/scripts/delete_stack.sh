#!/bin/bash

StackName=${1-progress-openedge}
aws cloudformation delete-stack --stack-name $StackName
