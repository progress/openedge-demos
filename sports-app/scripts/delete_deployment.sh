#!/bin/bash

StackName=${1-test}
aws cloudformation delete-stack --stack-name ${StackName}
