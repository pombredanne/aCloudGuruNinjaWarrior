#!/bin/bash


aws cloudformation create-stack --region eu-west-2 --capabilities CAPABILITY_NAMED_IAM  --stack-name DvtSdwanVpcLon --template-body file://DVT-VPCandSubnets.yaml --parameters ParameterKey=ClassABC,ParameterValue=10.1.1 ParameterKey=VPCName,ParameterValue=DVT_SDWAN ParameterKey=AlertContact1,ParameterValue=andy.mcneill@bt.com ParameterKey=AlertContact2,ParameterValue=marc.whiffen@bt.com ParameterKey=Resilience,ParameterValue=false


