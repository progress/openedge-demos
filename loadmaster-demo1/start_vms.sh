#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
TEMP=/tmp

function start_vm ()
{
  az vm start \
    --resource-group $RESOURCE_GROUP \
    --name $1 \
    --no-wait 
}

start_vm AccessVM
start_vm OEDB
start_vm PASOE1
start_vm PASOE2
start_vm WEB1
start_vm WEB2

exit
