#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
TEMP=/tmp

if az network nsg show --resource-group $RESOURCE_GROUP --name ${RESOURCE_GROUP}-nsg > $TEMP/output.json 2> /dev/null
then
    exit
fi

az network nsg create --resource-group $RESOURCE_GROUP --name ${RESOURCE_GROUP}-nsg > $TEMP/output.json
echo -n Allow SSH 
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name ${RESOURCE_GROUP}-nsg \
    --priority 1000 \
    --name SSH \
    --description "Allow SSH" \
    --destination-address-prefixes '*' \
    --destination-port-ranges 22 \
    --protocol Tcp | jq '.provisioningState'

echo -n Allow HTTP
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name ${RESOURCE_GROUP}-nsg \
    --priority 1010 \
    --name AllowAnyHTTPInbound \
    --description "Allow HTTP" \
    --destination-address-prefixes '*' \
    --destination-port-ranges 80 \
    --protocol Tcp | jq '.provisioningState'

echo -n Allow PASOE
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name ${RESOURCE_GROUP}-nsg \
    --priority 1020 \
    --name AllowAnyCustom8810Inbound \
    --description "Allow PASOE" \
    --destination-address-prefixes '*' \
    --destination-port-ranges 8810 \
    --protocol Tcp | jq '.provisioningState'

echo -n Allow Database
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name ${RESOURCE_GROUP}-nsg \
    --priority 1030 \
    --name AllowAnyCustom20000Inbound \
    --description "Allow Database" \
    --destination-address-prefixes '*' \
    --destination-port-ranges 20000 \
    --protocol Tcp | jq '.provisioningState'

