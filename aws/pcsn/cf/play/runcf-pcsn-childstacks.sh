#!/bin/bash

############
#SDWAN VNF
############
aws cloudformation create-stack --region eu-west-2 --stack-name testAS --template-body file://test_autoscaling.yml




