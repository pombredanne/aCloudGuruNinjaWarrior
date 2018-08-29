#!/bin/bash

#delete nsg

#This doesn't work  - just deletes deployment history not actual deployment resources which is a bit useless frankly
#az group deployment delete --resource-group SDWAN-rgplay --name sdwanNokiaNsg


az vm delete -n sdwan-nokia-autotest -g SDWAN-rgplay
az network nic delete -n sdwan-nokia-autotest-wan -g SDWAN-rgplay
az network nic delete -n sdwan-nokia-autotest-lan -g SDWAN-rgplay
az network public-ip delete -n sdwan-nokia-autotest-publicIP -g SDWAN-rgplay


