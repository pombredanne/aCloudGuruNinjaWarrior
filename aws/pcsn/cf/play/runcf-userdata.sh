#!/bin/bash

#aws cloudformation create-stack --region eu-west-2 --stack-name testUserData --template-body file://extractuserdata.yml --parameters ParameterKey=UserDataTest,ParameterValue=\"d5d953ccf7d0d301f50c04f04a9d1e9,vbond-259910.viptela.net,c7833570-8b14-4408-a4ce-662c1f7da2dc,BTWNBA\"

aws cloudformation create-stack --region eu-west-2 --stack-name testUserData --template-body file://userdataSingleString.yml --parameters file://userdataSingleStringNokia.json
