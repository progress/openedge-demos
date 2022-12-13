#!/bin/bash

RESOURCE_GROUP=DemoResourceGroup
TEMP=/tmp

function stop_vm ()
{
  az vm deallocate \
    --resource-group $RESOURCE_GROUP \
    --name $1 \
    --no-wait
}

stop_vm WEB2
stop_vm WEB1
stop_vm PASOE2
stop_vm PASOE1
stop_vm OEDB
stop_vm AccessVM

exit
