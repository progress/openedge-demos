#!/bin/bash

TEMP=/tmp
RESOURCE_GROUP=DemoResourceGroup

GITHUB_URL=https://raw.githubusercontent.com/progress/openedge-demos/azure-quickstart/azure-quickstart
S3_URL=https://${S3BUCKET}.s3.amazonaws.com/templates

# Build
BUILD_FOLDER=~/.build/azure-quickstart
mkdir -p $BUILD_FOLDER/out
cp -u *.template.json $BUILD_FOLDER/out
cp -u deploy.*.sh $BUILD_FOLDER/out
aws s3 sync $BUILD_FOLDER/out s3://${S3BUCKET}/templates/ --delete --acl public-read

cp azuredeploy.json ~/.build
sed -i "s|${GITHUB_URL}|${S3_URL}|g" ~/.build/azuredeploy.json

echo Deploying to Azure...
az deployment group create \
    --resource-group ${RESOURCE_GROUP} \
    --template-file ~/.build/azuredeploy.json \
    --parameters @~/.build/azuredeploy.parameters.json > $TEMP/output.json 2> $TEMP/error.json

echo Deployment to Azure completed with status $?

if [ "$?" -ne 0 ]
then
  cut -d: -f2- $TEMP/error.json | jq
else
  jq '.properties.outputs' < /tmp/output.json
fi

# jq < $TEMP/output.json