#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
TEMP=/tmp

function delete_vm ()
{
  az vm delete \
    --resource-group $RESOURCE_GROUP \
    --name $1 \
    --yes > $TEMP/output.json
}

# delete_vm WEB2
# delete_vm WEB1
# delete_vm PASOE2
# delete_vm PASOE1
# delete_vm OEDB
# delete_vm AccessVM

# az network public-ip delete --resource-group $RESOURCE_GROUP --name AccessVMPublicIP > $TEMP/output.json

az vmss delete --resource-group $RESOURCE_GROUP --name WebServer
az vmss delete --resource-group $RESOURCE_GROUP --name PASOE
az vm delete --resource-group $RESOURCE_GROUP --name DB0 --yes

# az network public-ip delete --resource-group $RESOURCE_GROUP --name DB0-ip

exit
az network nsg delete --resource-group $RESOURCE_GROUP --name webserver-nsg
az network nsg delete --resource-group $RESOURCE_GROUP --name pasoe-nsg
az network nsg delete --resource-group $RESOURCE_GROUP --name database-nsg

# az network nsg delete --resource-group $RESOURCE_GROUP --name accessvm-nsg
# az vm delete --resource-group $RESOURCE_GROUP --name AccessVM --yes

exit