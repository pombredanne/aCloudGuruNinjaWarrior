#!/bin/bash

aws cloudformation validate-template --template-body file://pcsn_cft_foundation.yml
#aws cloudformation validate-template --template-body file://pcsn_cft_vnf_sdwan.yml
#aws cloudformation validate-template --template-body file://pcsn_cft_vnf_others.yml
#aws cloudformation validate-template --template-body file://pcsn_cft_testapp.yml
#aws cloudformation validate-template --template-body file://demo_apps.yml


