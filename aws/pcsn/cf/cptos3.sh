#!/bin/bash

aws s3 cp pcsn_cft_foundation.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_testapp.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_vnf_sdwan.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_vnf_others.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_vnf_monitoring.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_flowlogs.yml s3://btdynspcsn/cftemplates/
aws s3 cp runTest.py s3://btdynspcsn/client/
aws s3 cp testPCSN/test1.json s3://btdynspcsn/client/
aws s3 cp vpcs/createdVpcs.json s3://btdynspcsn/client/



