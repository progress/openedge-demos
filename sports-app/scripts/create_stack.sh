#!/bin/bash

StackName=${1-progress-openedge}
PublicBucket=openedge-aws-dev
PrivateBucket=myprivatebucket3011

cd ~/quickstart-progress-openedge

# aws s3 sync ci s3://${PublicBucket}/quickstart-progress-openedge/ci/ --delete --acl public-read
aws s3 sync submodules s3://${PublicBucket}/quickstart-progress-openedge/submodules/ --delete --acl public-read
aws s3 sync templates s3://${PublicBucket}/quickstart-progress-openedge/templates/ --delete --acl public-read

aws cloudformation create-stack --stack-name $StackName \
    --capabilities CAPABILITY_IAM \
    --disable-rollback \
    --template-url https://s3.amazonaws.com/openedge-aws-dev/quickstart-progress-openedge/templates/master.template.yaml \
    --parameters ParameterKey=KeyPairName,ParameterValue=PUG2020 \
                 ParameterKey=RemoteAccessCIDR,ParameterValue=0.0.0.0/0 \
                 ParameterKey=WebAccessCIDR,ParameterValue=0.0.0.0/0 \
                 ParameterKey=EmailAddress,ParameterValue=egarcia@progress.com \
                 ParameterKey=QSS3BucketName,ParameterValue=${PublicBucket} \
                 ParameterKey=QSS3KeyPrefix,ParameterValue=quickstart-progress-openedge/ \
                 ParameterKey=InstanceType,ParameterValue=t3a.medium \
                 ParameterKey=MinScalingInstances,ParameterValue=1 \
                 ParameterKey=MaxScalingInstances,ParameterValue=3 \
                 ParameterKey=DBDeployPackage,ParameterValue=https://s3.amazonaws.com/${PrivateBucket}/db.tar.gz \
                 ParameterKey=PASOEDeployPackage,ParameterValue=https://s3.amazonaws.com/${PrivateBucket}/pas.tar.gz \
                 ParameterKey=WebDeployPackage,ParameterValue=https://s3.amazonaws.com/${PrivateBucket}/web.tar.gz \
                 "ParameterKey=AvailabilityZones,ParameterValue='us-east-1a,us-east-1b'"

