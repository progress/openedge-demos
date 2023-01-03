#!/bin/bash

RESOURCE_GROUP=1DemoResourceGroup
TEMP=/tmp

# az network public-ip delete --resource-group $RESOURCE_GROUP --name AccessVMPublicIP > $TEMP/output.json

az vmss delete --resource-group $RESOURCE_GROUP --name WebServer
az vmss delete --resource-group $RESOURCE_GROUP --name PASOE
az vm delete --resource-group $RESOURCE_GROUP --name DB0 --yes
az vm delete --resource-group $RESOURCE_GROUP --name AccessVM --yes
az vm delete --resource-group $RESOURCE_GROUP --name LoadMaster --yes

az network nic delete --resource-group $RESOURCE_GROUP --name DB0-nic
az network nic delete --resource-group $RESOURCE_GROUP --name AccessVM-nic
az network nic delete --resource-group $RESOURCE_GROUP --name LoadMaster-nic

az network nsg delete --resource-group $RESOURCE_GROUP --name webserver-nsg
az network nsg delete --resource-group $RESOURCE_GROUP --name pasoe-nsg
az network nsg delete --resource-group $RESOURCE_GROUP --name database-nsg
az network nsg delete --resource-group $RESOURCE_GROUP --name accessvm-nsg
az network nsg delete --resource-group $RESOURCE_GROUP --name LoadMaster-nsg

az network public-ip delete --resource-group $RESOURCE_GROUP --name AccessVM-ip
az network public-ip delete --resource-group $RESOURCE_GROUP --name LoadMaster-ip

# az network vnet delete --resource-group $RESOURCE_GROUP --name ${RESOURCE_GROUP}-vnet
exit

# az network nsg delete --resource-group $RESOURCE_GROUP --name accessvm-nsg
# az vm delete --resource-group $RESOURCE_GROUP --name AccessVM --yes


