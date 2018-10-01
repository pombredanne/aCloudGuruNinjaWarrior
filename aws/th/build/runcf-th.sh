#!/bin/bash

aws cloudformation create-stack --region eu-west-2 --stack-name testthglobal --timeout-in-minutes 60  --template-body file://th_NBmain.yml --parameters \
ParameterKey=genCustMne,ParameterValue='nhba' \
ParameterKey=genCustName,ParameterValue='nhsnorthumbria' \
ParameterKey=networkDomain,ParameterValue='thglobal.tk' \
ParameterKey=networkVPCCidr,ParameterValue=\"10.10.0\" \
ParameterKey=flavDeploymentType,ParameterValue='singleRegion'\
ParameterKey=genCreated,ParameterValue='01Aug2018'\
ParameterKey=genpudated,ParameterValue='01Aug2018'
ParameterKey=genCustomerBillingContact,ParameterValue='andy.mcneill@bt.com'
ParameterKey=genCustomerSupportContact,ParameterValue='andy.mcneill@bt.com'


