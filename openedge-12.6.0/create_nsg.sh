#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
NAME=OpenEdge-12.6.0
TEMP=/tmp

if az network nsg show --resource-group $RESOURCE_GROUP --name ${NAME}-nsg > $TEMP/output.json 2> /dev/null
then
    exit
fi

az network nsg create --resource-group $RESOURCE_GROUP --name ${NAME}-nsg > $TEMP/output.json
echo -n Allow SSH 
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name ${NAME}-nsg \
    --priority 1000 \
    --name SSH \
    --description "Allow SSH" \
    --destination-address-prefixes '*' \
    --destination-port-ranges 22 \
    --protocol Tcp | jq '.provisioningState'

