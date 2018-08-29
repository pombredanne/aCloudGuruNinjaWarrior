
REM aws cloudformation create-stack --stack-name Cust1Lon --template-body file://ManagedVPC-CreateVPC2.yaml --parameters ParameterKey=ClassABC,
ParameterValue=10.1.1 ParameterKey=CustName,ParameterValue=Cust1 ParameterKey=CustContact,ParameterValue=andy.mcneill@bt.com ParameterKey=Region,ParameterValue=Lon

Echo "VPC stack request created. Pausing while stack is deployed"

REM Sleep 300

Echo "Getting output values from VPC stack"

aws cloudformation describe-stacks --output text --stack-name Cust1Lon --query Stacks[0].Outputs[?OutputKey=='SubnetA1'].OutputValue > tmpFile 
set /P subneta1=<tmpFile 
del tmpFile
echo %subneta1%
aws cloudformation describe-stacks --output text --stack-name Cust1Lon --query Stacks[0].Outputs[?OutputKey=='SubnetA2'].OutputValue > tmpFile 
set /P subneta2=<tmpFile 
del tmpFile
echo %subneta2%
aws cloudformation describe-stacks --output text --stack-name Cust1Lon --query Stacks[0].Outputs[?OutputKey=='VPC'].OutputValue > tmpFile 
set /P vpc=<tmpFile 
del tmpFile
echo %vpc%

REM aws cloudformation create-stack --stack-name Cust1Lon --template-body file://ManagedVPC-CreateNokiaNSG.yaml --parameters --parameters 
ParameterKey=KeyName, ParameterValue=dvtkp ParameterKey=SUBNETID, ParameterValue=%subneta1% ParameterKey=SUBNETIDPORT1,ParameterValue=%subneta2% ParameterKey=VPCNAME,ParameterValue=%vpc% 
ParameterKey=CustName,ParameterValue=Cust1 ParameterKey=AMI,ParameterValue=TBD ParameterKey=InstanceType,ParameterValue=t2.small


