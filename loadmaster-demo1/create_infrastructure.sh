#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
TEMP=/tmp

LM_IP_ADDRESS=52.224.247.9
PASOE_PORT=8810

function create_vm ()
{
  VM_IMAGE=${VM_IMAGE-UbuntuLTS}
  VM_SIZE=${VM_SIZE-Standard_B2s}
  NAME=$1
  CUSTOM_DATA=$2

  echo Resource $NAME...
  if az vm show --resource-group $RESOURCE_GROUP --name $NAME --show-details > $TEMP/output.json 2> /dev/null
  then
    return
  fi
  az vm create \
    --resource-group $RESOURCE_GROUP \
    --name $NAME \
    --image $VM_IMAGE \
    --size $VM_SIZE \
    --nsg ${RESOURCE_GROUP}-nsg \
    --public-ip-sku Standard \
    --public-ip-address "$PUBLIC_IP_ADDRESS" \
    --nic-delete-option delete \
    --os-disk-delete-option delete \
    --admin-username azureuser \
    --ssh-key-values ~/clouddrive/Azure_key.pub \
    --custom-data "$CUSTOM_DATA" > $TEMP/output.json
}

./create_nsg.sh

VM_SIZE=Standard_B1s PUBLIC_IP_ADDRESS=AccessVMPublicIP create_vm AccessVM

# Create OEDB VM
VM_IMAGE=OpenEdge-12.6.0
create_vm OEDB ./custom-data.db

az vm show --resource-group $RESOURCE_GROUP --name OEDB --show-details > $TEMP/output.json
DBHOSTNAME=`jq -r '.privateIps' < $TEMP/output.json`

# Create PASOE VMs
cp ./custom-data.pas $TEMP/custom-data.pas
sed -i "s|HOST|${DBHOSTNAME}|" $TEMP/custom-data.pas
create_vm PASOE1 $TEMP/custom-data.pas
create_vm PASOE2 $TEMP/custom-data.pas

# Create WEB VMs
VM_IMAGE=UbuntuLTS
cp ./custom-data.web $TEMP/custom-data.web
sed -i "s|HOST|${LM_IP_ADDRESS}|" $TEMP/custom-data.web
sed -i "s|PORT|${PASOE_PORT}|" $TEMP/custom-data.web
create_vm WEB1 $TEMP/custom-data.web
create_vm WEB2 $TEMP/custom-data.web

exit
