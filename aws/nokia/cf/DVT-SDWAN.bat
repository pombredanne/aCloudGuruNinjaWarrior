
7z a DVT-VPCandSubnets.zip DVT-VPCandSubnets.yaml DVT-VPCandSubnets_param.json

aws s3 cp DVT-VPCandSubnets.zip s3://btdyns-cf-templates



REM aws cloudformation create-stack --region eu-west-2 --capabilities CAPABILITY_NAMED_IAM  --stack-name DvtSdwanVpcLon --template-body file://DVT-VPCandSubnets.yaml --parameters https://s3.eu-west-2.amazonaws.com/btdyns-cf-templates/DVT-VPCandSubnets_param.json
REM aws cloudformation create-stack --region eu-west-2 --capabilities CAPABILITY_NAMED_IAM  --stack-name DvtSdwanVpcLon --template-body file://DVT-VPCandSubnets.yaml --parameters s3://btdyns-cf-templates/DVT-VPCandSubnets_param.json


REM aws cloudformation create-stack --region eu-west-2 --capabilities CAPABILITY_NAMED_IAM  --stack-name DvtSdwanVpcLon --template-body file://DVT-VPCandSubnets.yaml --parameters ParameterKey=ClassABC,ParameterValue=10.1.1 ParameterKey=VPCName,ParameterValue=DVT_SDWAN ParameterKey=AlertContact1,ParameterValue=andy.mcneill@bt.com ParameterKey=AlertContact2,ParameterValue=marc.whiffen@bt.com ParameterKey=Resilience,ParameterValue=false


REM aws cloudformation create-stack --region eu-west-2 --stack-name DvtSdwanNsgLon --template-body file://DVT-NSG2p.yaml --parameters ParameterKey=KeyName,ParameterValue=nsgvkp1 ParameterKey=VPCName,ParameterValue=DvtSdwanVpcLon ParameterKey=VPCStackName,ParameterValue=DvtSdwanVpcLon ParameterKey=AMI,ParameterValue=ami-e2a54385 ParameterKey=InstanceType,ParameterValue=t2.small ParameterKey=InstanceName,ParameterValue=DvtSdwanNsgLon


REM cloudformation create-stack --region eu-west-2 --stack-name DvtSdwanJumpAndTestLon --template-body file://DVT-JumpAndTest.yaml --parameters ParameterKey=KeyName,ParameterValue=jump1kp ParameterKey=VPCName,ParameterValue=DvtSdwanVpcLon ParameterKey=VPCStackName,ParameterValue=DvtSdwanVpcLon ParameterKey=SDWANStackName,ParameterValue=DvtSdwanNsgLon ParameterKey=AMIJump,ParameterValue=ami-e2a54385 ParameterKey=InstanceTypeJump,ParameterValue=t2.small ParameterKey=InstanceNameJump,ParameterValue=DvtSdwanJumpLon ParameterKey=AMITest,ParameterValue=ami-e2a54385 ParameterKey=InstanceTypeTest,ParameterValue=t2.small ParameterKey=InstanceNameTest,ParameterValue=DvtSdwanTestLon ParameterKey=TestSubnetAddress,ParameterValue=10.1.1.128/28 ParameterKey=TestExternalTarget,ParameterValue=10.10.10.0/24

