#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
TEMP=/tmp

function delete_vm ()
{
  az vm delete \
    --resource-group $RESOURCE_GROUP \
    --name $1 \
    --yes
}

delete_vm WEB2
delete_vm WEB1
delete_vm PASOE2
delete_vm PASOE1
# delete_vm OEDB

exit
