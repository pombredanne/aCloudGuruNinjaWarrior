#!/bin/bash

#create nsg

az group deployment create \
--name sdwanNokiaNsg \
--resource-group SDWAN-rgplay \
--template-file sdwanNokiaNsg.json \
--parameters nsgName=sdwan-nokia-autotest \
         nsgDisk=sdwannokia5-2-1test \
         nsgVmSize=Standard_B2s \
         nsgVnet=SDWAN-vnetplay \
         nsgPublicSubnet=sdwan-pu \
         nsgPrivateSubnet=sdwan-pr \
         nsgSecurityGroup=sdwan-sg \

