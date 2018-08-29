#!/bin/bash


##############################################
#Test foundation stack
##############################################
#TBD put region array and lopp her show can dmeonstrate deployment to all global regions
#TBD include describe, update and delete stacks commands
#TBD add tags to foundation stack request
aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnFoundation --template-body file://pcsn_cft_foundation.yml 
--timeout-in-minutes 15 \
--parameters \
ParameterKey=VPCID,ParameterValue=vpc-8baebde2 \
ParameterKey= NetworkAddressRange,ParameterValue=10.0.10.0 \
ParameterKey=NetworkExternalAddressRanges,ParameterValue=\"172.10.10.0/24,172.11.11.0/24,172.11.12.0/24\" \
ParameterKey=NetworkInternalHostAddressRanges,ParameterValue=\"10.0.80.0/24,10.0.81.0/24\" \
ParameterKey=VNFServiceChain,ParameterValue=\"WAN<->Nokia SDWAN<->Fortinet<->Hosts\" \
ParameterKey=FlavourResilience,ParameterValue=SingleAZ \
ParameterKey=FlavourPerformance,ParameterValue=High \
ParameterKey=VNFCiscoSDWANMgtAddresses,ParameterValue=\"172.0.10.0/24,172.1.10.0/24\" \
ParameterKey=VNFCiscoSDWANUserData1,ParameterValue=\"d5d953ccf7d0d301f50c04f04a9d1e9\" \
ParameterKey=VNFCiscoSDWANUserData2,ParameterValue=\"vbond-259910.viptela.net\" \
ParameterKey=VNFCiscoSDWANUserData3,ParameterValue=\"c7833570-8b14-4408-a4ce-662c1f7da2dc\" \
ParameterKey=VNFCiscoSDWANUserData4,ParameterValue="BT WNBA - 20446" \
ParameterKey=CiscoSDWANMonitor,ParameterValue=true \
ParameterKey=MiscFlowLogs,ParameterValue=false \
ParameterKey=MiscRegionInstance,ParameterValue=1 \
ParameterKey=MiscDeployTestApp,ParameterValue=false \
ParameterKey=MiscDevTest,ParameterValue=true \
ParameterKey=MiscTimeStampCreate,ParameterValue=August1st2018 \
ParameterKey=MiscTimeStampUpdate,ParameterValue=August1st2018 \


##############################################
#Test child stacks
##############################################

############
#Monitoring
############
#aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnMonitoring --template-body file://pcsn_cft_vnf_monitoring.yml \
#--timeout-in-minutes 5    \
#--parameters \
#ParameterKey=InstanceID,ParameterValue=i-02b209afb85dd1939 \
#ParameterKey=VNFName,ParameterValue=testVNF \
#ParameterKey=AlarmNameBase,ParameterValue=btpcsn_vnf_eu-west-2_1_vpc-12345678 \
#ParameterKey=Created,ParameterValue=August1st2018 \

############
#TestApp
############
#aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnTestApp --template-body file://pcsn_cft_testapp.yml \
#--timeout-in-minutes 5    \
#--parameters \
#ParameterKey=VPCID,ParameterValue=vpc-8baebde2 \
#ParameterKey=SubnetTestID,ParameterValue=subnet-31d40b4b \
#ParameterKey=InstanceNameTest,ParameterValue=pcsn_testapp_eu-west-2_1_vpc-8baebde2 \
#ParameterKey=RequestQueue,ParameterValue=btpcsn_sqs_testapp_req_eu-west-2_1_vpc-12345678 \
#ParameterKey=ResponseQueue,ParameterValue=btpcsn_sqs_testapp_resp_eu-west-2_1_vpc-12345678 \
#ParameterKey=Created,ParameterValue=August1st2018 \


############
#SDWAN VNF
############
#aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnSdwanVnf --template-body file://pcsn_cft_vnf_sdwan.yml \
#--timeout-in-minutes 5    \
#--parameters \
#ParameterKey=VPCID,ParameterValue=vpc-8baebde2 \
#ParameterKey=SubnetWAN,ParameterValue=subnet-52d10c28 \
#ParameterKey=SubnetLAN,ParameterValue=subnet-31d40b4b \
#ParameterKey=NaclWAN,ParameterValue=acl-0c678c64 \
#ParameterKey=NaclLAN,ParameterValue=acl-0c678c64 \
#ParameterKey=InstanceName,ParameterValue=btpcsn_vnf_ciscosdwan__eu-west-2_1_vpc-12345678 \
#ParameterKey=UserDataNokia1,ParameterValue=\"usertestparam1,usertestparam2\" \
#ParameterKey=UserDataCisco1,ParameterValue="d5d953ccf7d0d301f50c04f04a9d1e9" \
#ParameterKey=UserDataCisco2,ParameterValue="vbond-259910.viptela.net" \
#ParameterKey=UserDataCisco3,ParameterValue="c7833570-8b14-4408-a4ce-662c1f7da2dc" \
#ParameterKey=UserDataCisco4,ParameterValue="BT WNBA - 20446" \
#ParameterKey=SDWANType,ParameterValue=Cisco \
#ParameterKey=DevTest,ParameterValue=true \
#ParameterKey=FlavourPerformance,ParameterValue=High \
#ParameterKey=PlacementGroup,ParameterValue=testpg \
#ParameterKey=Created,ParameterValue=August1st2018 \




