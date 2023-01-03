#!/bin/bash

RESOURCE_GROUP=1DemoResourceGroup
TEMP=/tmp

case $1 in
accessvm)
  az vm delete --resource-group $RESOURCE_GROUP --name AccessVM --yes
  az network nic delete --resource-group $RESOURCE_GROUP --name AccessVM-nic
  az network nsg delete --resource-group $RESOURCE_GROUP --name accessvm-nsg
  az network public-ip delete --resource-group $RESOURCE_GROUP --name AccessVM-ip
  ;;
loadmaster)
  az vm delete --resource-group $RESOURCE_GROUP --name LoadMaster --yes
  az network nic delete --resource-group $RESOURCE_GROUP --name LoadMaster-nic
  az network nsg delete --resource-group $RESOURCE_GROUP --name LoadMaster-nsg
  az network public-ip delete --resource-group $RESOURCE_GROUP --name LoadMaster-ip
  ;;
vnet)
  az network vnet delete --resource-group $RESOURCE_GROUP --name ${RESOURCE_GROUP}-vnet
  ;;
*)
  az vmss delete --resource-group $RESOURCE_GROUP --name WebServer
  az vmss delete --resource-group $RESOURCE_GROUP --name PASOE
  az vm delete --resource-group $RESOURCE_GROUP --name DB0 --yes
  az network nic delete --resource-group $RESOURCE_GROUP --name DB0-nic
  az network nsg delete --resource-group $RESOURCE_GROUP --name webserver-nsg
  az network nsg delete --resource-group $RESOURCE_GROUP --name pasoe-nsg
  az network nsg delete --resource-group $RESOURCE_GROUP --name database-nsg
  ;;
esac
