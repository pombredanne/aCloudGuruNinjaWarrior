#!/bin/bash

aws s3 cp pcsn_cft_foundation.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_testapp.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_vnf_sdwan.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_vnf_others.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_vnf_monitoring.yml s3://btdynspcsn/cftemplates/
aws s3 cp pcsn_cft_flowlogs.yml s3://btdynspcsn/cftemplates/



