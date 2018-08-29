#!/bin/bash

#tbd - Create python script to run tests. Run test per json config in specific sub directory. Run all tests in for loop (deleting stack each time if successful).  Use describe stack to get status and print event (using describe stack events) upon failure, also deleting stack. Will need to do waits between creating and checking status and deleting. 

aws cloudformation create-stack --region eu-west-2 --stack-name testpcsnFoundation --template-body file://pcsn_cft_foundation.yml --debug --role-arn arn:aws:iam::813970735459:role/btpcsn_iam_role --timeout-in-minutes 15 --parameters file://testparams/test1.json
