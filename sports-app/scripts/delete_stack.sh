#!/bin/bash

StackName=${1-demo}
aws cloudformation delete-stack --stack-name $StackName
