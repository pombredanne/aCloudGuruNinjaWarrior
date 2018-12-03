#!/bin/bash

aws cloudformation create-stack --region us-east-1 --stack-name demoApp --template-body file://demo_apps.yml --parameters \
ParameterKey=VPCID,ParameterValue=vpc-0f339d7d981b04d61 \
ParameterKey=IGWID,ParameterValue=igw-02b47733fa8a87c73 \
ParameterKey=HostSubnetAddress,ParameterValue=10.29.10.0/24 \
ParameterKey=AppType,ParameterValue=ERP \
ParameterKey=AZ,ParameterValue=us-east-1a

aws cloudformation create-stack --region us-east-2 --stack-name demoApp --template-body file://demo_apps.yml --parameters \
ParameterKey=VPCID,ParameterValue=vpc-06f39d630ab640a15 \
ParameterKey=IGWID,ParameterValue=igw-0c841b539ee03b1d5 \
ParameterKey=HostSubnetAddress,ParameterValue=10.30.10.0/24 \
ParameterKey=AppType,ParameterValue=ERP \
ParameterKey=AZ,ParameterValue=us-east-2a


aws cloudformation create-stack --region eu-central-1 --stack-name demoApp --template-body file://demo_apps.yml --parameters \
ParameterKey=VPCID,ParameterValue=vpc-067290c4e8c0bdcb8 \
ParameterKey=IGWID,ParameterValue=igw-0527d6b7383e32d77 \
ParameterKey=HostSubnetAddress,ParameterValue=10.32.10.0/24 \
ParameterKey=AppType,ParameterValue=CRM \
ParameterKey=AZ,ParameterValue=eu-central-1a


aws cloudformation create-stack --region ap-south-1 --stack-name demoApp --template-body file://demo_apps.yml --parameters \
ParameterKey=VPCID,ParameterValue=vpc-067e6a9926ab538c5 \
ParameterKey=IGWID,ParameterValue=igw-0753120ae13b14aff \
ParameterKey=HostSubnetAddress,ParameterValue=10.31.10.0/24 \
ParameterKey=AppType,ParameterValue=CRM \
ParameterKey=AZ,ParameterValue=ap-south-1a
