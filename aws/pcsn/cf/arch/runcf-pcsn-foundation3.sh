#!/bin/bash

#aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnFoundation --template-body file://pcsn_cft_foundation.yml \
aws cloudformation create-stack  --region eu-west-2 --stack-name testpcsnFoundation3 --template-body file://pcsn_cft_foundation.yml \
--parameters \
ParameterKey=NetworkVPCID,ParameterValue='vpc-8baebde2' \
ParameterKey=NetworkAddressRange,ParameterValue='10.0.78' \
ParameterKey=NetworkExternalAddressRanges,ParameterValue=\"172.92.10.0/24,172.11.11.0/24,172.11.12.0/24\" \
ParameterKey=NetworkInternalHostAddressRanges,ParameterValue=\"10.0.80.0/24,10.0.81.0/24\" \
ParameterKey=VNFServiceChain,ParameterValue='WAN<->Nokia SDWAN<->Fortinet<->Hosts' \
ParameterKey=FlavourResilience,ParameterValue=SingleAZ \
ParameterKey=FlavourPerformance,ParameterValue=Restricted \
ParameterKey=VNFNokiaSDWANMonitor,ParameterValue=true \
ParameterKey=VNFNokiaSDWANMgtAddressRanges,ParameterValue=\"172.0.10.0/24,172.1.10.0/24\" \
ParameterKey=VNFNokiaSDWANUserData1,ParameterValue=\"proxy.dc.nuagedemo.net\" \
ParameterKey=VNFNokiaSDWANUserData2,ParameterValue=\"enterprise12345678\" \
ParameterKey=VNFNokiaSDWANUserData3,ParameterValue=\"other\" \
ParameterKey=VNFNokiaSDWANUserData4,ParameterValue=\"other\" \
ParameterKey=VNFFortinetMonitor,ParameterValue=true \
ParameterKey=VNFFortinetMgtAddressRanges,ParameterValue=\"172.0.10.0/24,172.1.10.0/24\" \
ParameterKey=VNFFortinetUserData1,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData2,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData3,ParameterValue=placeholder \
ParameterKey=VNFFortinetUserData4,ParameterValue=placeholder \
ParameterKey=MiscFlowLogs,ParameterValue=true \
ParameterKey=MiscRegionInstance,ParameterValue=3 \
ParameterKey=MiscDeployTestApp,ParameterValue=true \
ParameterKey=MiscDevTest,ParameterValue=false \
ParameterKey=MiscTimeStampCreate,ParameterValue=August8st2018 \
ParameterKey=MiscTimeStampUpdate,ParameterValue=August1st2018 \
ParameterKey=MiscDevTestNokiaSDWANLANIf,ParameterValue=\"eni-b2cb4ee6\" \
ParameterKey=MiscDevTestNokiaSDWANAMI,ParameterValue=ami-ee31c489

