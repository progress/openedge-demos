#!/bin/bash

# set -x

RESOURCE_GROUP=DemoResourceGroup
NAME=OpenEdge-12.6.0
TEMP=/tmp

IP_ADDRESS=

function create_vm ()
{
  NAME=$1
  az vm create \
    --resource-group $RESOURCE_GROUP \
    --name $NAME \
    --image UbuntuLTS \
    --size Standard_B2s \
    --public-ip-sku Standard \
    --nic-delete-option delete \
    --os-disk-delete-option delete \
    --admin-username azureuser \
    --ssh-key-values ~/clouddrive/Azure_key.pub > $TEMP/output.json
}

function delete_vm ()
{
  NAME=$1
  az vm delete \
    --resource-group $RESOURCE_GROUP \
    --name $NAME \
    --yes > $TEMP/output.json

  az network public-ip delete \
    --resource-group $RESOURCE_GROUP \
    --name ${NAME}PublicIP > $TEMP/output.json
  az network nsg delete \
    --resource-group $RESOURCE_GROUP \
    --name ${NAME}NSG > $TEMP/output.json
}

function copy_files ()
{
  scp \
    -i ~/Azure_key.pem \
    -o UserKnownHostsFile=/dev/null \
    -o StrictHostKeyChecking=no \
    $* \
    azureuser@${IP_ADDRESS}:/files
}

function run_cmd ()
{
  ssh \
    -i ~/Azure_key.pem \
    -o UserKnownHostsFile=/dev/null \
    -o StrictHostKeyChecking=no \
    azureuser@${IP_ADDRESS} \
    "$1"
}

if ! az vm show --resource-group $RESOURCE_GROUP --name $NAME --show-details > $TEMP/output.json 2> /dev/null
then
  create_vm $NAME
  IP_ADDRESS=`jq -r '.publicIpAddress' < $TEMP/output.json`
fi

if [ "$IP_ADDRESS" == "" ]
then
  IP_ADDRESS=`jq -r '.publicIps' < $TEMP/output.json`
fi

run_cmd "sudo mkdir -p /files; sudo chown azureuser /files"
copy_files ~/clouddrive/PROGRESS_OE_12.6_LNX_64.tar.gz ~/clouddrive/response_12.6.ini

cd ../..
tar czf ~/clouddrive/openedge-demos.tar.gz openedge-demos
copy_files ~/clouddrive/openedge-demos.tar.gz

run_cmd "tar xzf /files/openedge-demos.tar.gz; cd openedge-demos/openedge-12.6.0; sudo bash ./setup.sh"

run_cmd "ls -l /psc/dlc"

run_cmd "sudo waagent -deprovision+user -force"

az vm deallocate \
  --resource-group $RESOURCE_GROUP \
  --name OpenEdge-12.6.0 > $TEMP/output.json

az vm generalize \
  --resource-group $RESOURCE_GROUP \
  --name OpenEdge-12.6.0 > $TEMP/output.json

az image create \
  --resource-group $RESOURCE_GROUP \
  --name $NAME \
  --source $NAME > $TEMP/output.json

delete_vm $NAME

