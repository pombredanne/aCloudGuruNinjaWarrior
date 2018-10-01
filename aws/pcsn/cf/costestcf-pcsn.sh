#!/bin/bash

aws cloudformation estimate-template-cost --region eu-west-2 --template-body file://pcsn_cft_foundation.yml --parameters file://testparams/test1.json


