#!/bin/bash

#aws cloudformation validate-template --template-body file://th_NBmain.yml
#aws cloudformation validate-template --template-body file://th_objStorageLayer.yml
#aws cloudformation validate-template --template-body file://th_webLayer.yml
aws cloudformation validate-template --template-body file://th_notify.yml
#aws cloudformation validate-template --template-body file://th_networksAndAccess.yml
#aws cloudformation validate-template --template-body file://th_dbLayer.yml


