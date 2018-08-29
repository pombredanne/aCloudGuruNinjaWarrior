#!/bin/bash

aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnFoundation --template-body file://pcsn_cft_foundation.yml \
 --parameters \
--timeout-in-minutes 15 \
--parameters \
--timeout-in-minutes 15 \
--parameters \
ParameterKey=NetworkVPCID,ParameterValue='vpc-8baebde2' \
ParameterKey=NetworkAddressRange,ParameterValue='10.0.10.0' \
ParameterKey=NetworkExternalAddressRanges,ParameterValue=\"172.10.10.0/24,172.11.11.0/24,172.11.12.0/24\" \
ParameterKey=NetworkInternalHostAddressRanges,ParameterValue=\"10.0.80.0/24,10.0.81.0/24\" \
ParameterKey=VNFServiceChain,ParameterValue='WAN<->Cisco SDWAN<->Fortinet<->Hosts' \
ParameterKey=FlavourResilience,ParameterValue=SingleAZ \
ParameterKey=FlavourPerformance,ParameterValue=High \
ParameterKey=VNFCiscoSDWANMgtAddressRanges,ParameterValue=\"172.0.10.0/24,172.1.10.0/24\" \
ParameterKey=VNFCiscoSDWANUserData1,ParameterValue=\"d5d953ccf7d0d301f50c04f04a9d1e9\" \
ParameterKey=VNFCiscoSDWANUserData2,ParameterValue=\"vbond-259910.viptela.net\" \
ParameterKey=VNFCiscoSDWANUserData3,ParameterValue=\"c7833570-8b14-4408-a4ce-662c1f7da2dc\" \
ParameterKey=VNFCiscoSDWANUserData4,ParameterValue='BT WNBA - 20446' \
ParameterKey=VNFFortinetMonitor,ParameterValue=true \
ParameterKey=VNFFortinetMgtAddressRanges,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData1,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData2,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData3,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData4,ParameterValue=placeholder \
ParameterKey=MiscFlowLogs,ParameterValue=false \
ParameterKey=MiscRegionInstance,ParameterValue=1 \
ParameterKey=MiscDeployTestApp,ParameterValue=false \
ParameterKey=MiscDevTest,ParameterValue=true \
ParameterKey=MiscTimeStampCreate,ParameterValue=August1st2018 \
ParameterKey=MiscTimeStampUpdate,ParameterValue=August1st2018 \
