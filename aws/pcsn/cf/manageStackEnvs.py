##########################################################################
#manageStackEnvs - create/update/delete pcsn stacks
##########################################################################
#future - put region in file name to specific region for each test (need to do when creating client
#future - use file name to denote if create or update
#future - pass option to run single test
#future - pass option to abort/continue on test failure
#future - to run stacks in parallel build up an array of deployed stacks and then call the check status function separately for each stack in array (need to have an in progress stack array and a complete stack array. then iterate array to show final status. 

#future - add in ability to create virtual dc alongside pcsn deployment. alongside <region>.json config file for pcsn have a <region>_dc_config.json and <region>_dc_cf.yml. Subnet cidr(s) of dc should match the internal address list for the pcsn deployment

#future - sdwan playbooks. run set up playbook before stack creation (including grabing subnet/other info from pcsn params) and post deployment playbook after (for nokia - also need to grab output from cf for post deployment playbook. e.g lan ip and mac address). Also need to account for deletes.i# nuage playbooks - https://github.com/nuagenetworks/vspk-ansible/wiki

import json
import boto3
import traceback
import datetime
import os
import time
import argparse
import vmanage

#Global vars
vedgeUuid=""
vmanage_ip=""
vmanage_username=""
vmanage_password="" 

def main():
    
    print("Entered test client")

    results = []
    #stackName = "devtestPCSNFoundation"
    stackName = ""
    retryGap = 30
    status=""
    actionCreate=False
    actionDelete=False
    actionUpdate=False

    parser = argparse.ArgumentParser()
    parser.add_argument('-a','--action', help='Stack action', required=True)
    parser.add_argument('-d','--directory', help='Params directory', required=True)
    parser.add_argument('-cvm','--configureVmanage', help='Cisco vmanage integration', required=False)
    parser.add_argument('-cvsd','--configureVsd', help='Nokia vsd integration', required=False)
    args = vars(parser.parse_args())
    if args['action'] == "create":
      actionCreate = True
    elif args['action'] == "delete":
      actionDelete = True
    elif args['action'] == "update":
      actionUpdate = True
    else:
      print("Unknown action option " + args['action'])
      exit()
    if args['directory'] == None:
      testDir = "testPCSN"
    else:
      testDir = args['directory']
    if args['configureVmanage'] == None:
      cvmIntegration = False
    else:
      cvmIntegration = True
    if args['configureVsd'] == None:
      cvsdIntegration = False
    else:
      cvsdIntegration = True
       
    #print(testDir)
    #exit()
    
    try:

       client = boto3.client('cloudformation')


       ####################################
       #Get test params
       ####################################

       for file in os.listdir(testDir):
          #filename = os.fsdecode(file)
          if file.endswith(".json"): 
             print("------------------")
             print("TEST: " + file )
             print("------------------")

             if "/" in testDir:
                testDir = testDir[0:len(testDir)-1] 

             regionNamePos = len(file) - 5
             regionName = file[0:regionNamePos]
             stackName = testDir
             print("Stack name: " + stackName)
             print("Region name: " + regionName)

             with open(testDir + "/" + file) as f_in:
                params=json.load(f_in)

             templateFile = open("pcsn_cft_foundation.yml", "r")
             template = (templateFile.read())


             #print(params)

             startTime = datetime.datetime.now()
       ####################################
       #Logon to AWS and assume role
       ####################################
             print("Logging on and assuming role ...")
             session = boto3.session.Session()
             credentials = session.get_credentials()
             current_credentials = credentials.get_frozen_credentials()
             sess = boto3.session.Session(aws_access_key_id=current_credentials.access_key, aws_secret_access_key=current_credentials.secret_key)
             sts_connection = sess.client('sts')
             #in prod would create role arn from account number received from customer
             assume_role_object = sts_connection.assume_role(RoleArn="arn:aws:iam::813970735459:role/btpcsn_iam_role", RoleSessionName="pcsnSession",DurationSeconds=900)
             credentials = assume_role_object['Credentials']

             #in prod would use region as paramter from region received from customer
             client = boto3.client('cloudformation',aws_access_key_id=credentials["AccessKeyId"],aws_secret_access_key=credentials["SecretAccessKey"],aws_session_token=credentials["SessionToken"],region_name=regionName)
             print("Logged on")
            

       ####################################
       #Create stack
       ####################################
             if actionCreate == True:

                if cvmIntegration == True:
                    bootstrapCiscoSdwan(params, testDir + "/" + file)

                if cvsdIntegration == True:
                    bootstrapNokiaSdwan(params, testDir + "/" + file)

                print("Creating stack ...")

                response_create_stack = client.create_stack(StackName=stackName, TemplateURL="https://s3.amazonaws.com/btdynspcsn/cftemplates/pcsn_cft_foundation.yml",Parameters=params,DisableRollback=True)

                print("Stack creation initiated")
                print("Checking for successful completion ...")


                #just testing querying response object here
                #print(stack["Stacks"][0]["StackId"])
                #print(stack["Stacks"][0]["StackStatus"])
                #print(stack["Stacks"][0]["CreationTime"])
                #if "StackStatusReason" in stack["Stacks"][0]:  
                #   print(stack["Stacks"][0]["StackStatusReason"])

                ####################################
                #Poll for stack completion
                ####################################
                stack = client.describe_stacks(StackName=stackName)
                status = stack["Stacks"][0]["StackStatus"]
                while status=="CREATE_IN_PROGRESS":
                    time.sleep(retryGap)
                    print("Checking for successful completion ...")
                    stack = client.describe_stacks(StackName=stackName)
                    status = stack["Stacks"][0]["StackStatus"]

                if status!="CREATE_COMPLETE":
                    stack = client.describe_stacks(StackName=stackName)
                    stackEvents = client.describe_stack_events(StackName=stackName)
                    endTime = datetime.datetime.now()
                    #print(stackEvents)
                    for event in stackEvents["StackEvents"]:
                        if "ResourceStatusReason" in event:
                            failureReason = event["ResourceStatusReason"]
                        if("The following resource(s) failed to create" not in failureReason and "Resource creation Initiated" not in failureReason and "Resource creation cancelled" not in failureReason):
                            print(failureReason)
                            break
                     
                    results.append("test: " + file + " , time: " + str((endTime - startTime).total_seconds()) + " ERROR: " + failureReason) 
                    print("Stack completion failure")
                else:
                    endTime = datetime.datetime.now()
                    results.append("test: " + file + " , time: " + str((endTime - startTime).total_seconds()) + " SUCCESS") 
                    print("Stack completed successfully")


      
       ####################################
       #Delete stack
       ####################################
             if actionDelete == True:
                print("Deleting stack ...")
                stack = client.delete_stack(StackName=stackName)
                print("Stack deletion initiated")
                stack = client.describe_stacks(StackName=stackName)
                status = stack["Stacks"][0]["StackStatus"]
                while status=="DELETE_IN_PROGRESS":
                    time.sleep(retryGap)
                    print("Checking for successful completion ...")
                    try:
                       stack = client.describe_stacks(StackName=stackName)
                       status = stack["Stacks"][0]["StackStatus"]
                    except Exception as e: 
                       #continue as exception is expected if stack no long exists
                       status="DELETED" 
                       print("Stack deleted")

          
                if cvmIntegration == True:
                   decommissionCiscoSdwan()

                if cvsdIntegration == True:
                   decommissionNokiaSdwan()

                   
             if actionUpdate == True:
                print("Update stack action to be configured.")
                exit()

       #Print results
       if actionCreate == True:
            print("\n\n")
            print("----------------------")
            print("COMPLETED SUCCESSFULLY")
            print("----------------------")
            for result in results:
                print(result)


            print("\n\n")

    except Exception as e: 
       print("ERROR: ")
       traceback.print_exc()


def bootstrapCiscoSdwan(params, paramFile):

   #get bootstrap string and uuid from pcsn params. uuid is a 36 char string, otp is 32 char

   paramPos=0
   for param in params:
      if param["ParameterKey"] == "VNFCiscoSDWANUserData":
         bootString = param["ParameterValue"]
         break
      paramPos+=1

   uuidPos = bootString.find("uuid")
   vedgeUuidTmp = bootString[uuidPos:]
   vedgeUuid = vedgeUuidTmp[7:43].strip()
   otpPos = bootString.find("otp") #don't actually need to extract otp yet but may in future
   vedgeOtpTmp = bootString[otpPos:]
   vedgeOtp = vedgeOtpTmp[6:38].strip()
   print(vedgeUuid)
   print(vedgeOtp)

   #newBootStrap = "#cloud-config\nvinitparam:\n - otp : c33c065ef66b369362a77a7e3cd4b789\n - vbond : vbond-259910.viptela.net\n - uuid : 52c7911f-c5b0-45df-b826-3155809a2a1a\n - org : BT WNBA - 20446"

   #tbd - get these from config at a later date
   vmanage_ip = "vmanage-259910.viptela.net"
   vmanage_username = "andymcneill" 
   vmanage_password = "password1"

   vmobj = rest_api_lib(vmanage_ip, vmanage_username, vmanage_password)
   
   #Generate bootstrap
   print("Generating bootstrap...") 
   payload = "{'uuid':['" + vedgeUuid + "'],'bootstrapConfigType':'cloudinit'}"
   response = vmobj.post_request("system/device/bootstrap/devices?api_key=export", payload)
   print("Bootstrap generated. Response : " + response) 

   #Get bootstrap details
   print("Getting bootstrap details ...") 
   response = vmobj.get_request("/system/device/bootstrap/device/" + vedgeUuid + "?configtype=cloudinit")
   print("Got bootstrap details. Response : " + response) 
   newBootstrap=json.load(response)["bootstrapConfig"]
   #update param file with ne bootstrap so can be reused
   newParam = "{'ParameterKey': 'VNFCiscoSDWANUserData' , 'ParameterValue': " + newBootStrap + "}"
   params[paramPos] = newParam
   with open(paramFile + '.blah', 'w') as f:
      json.dump(params, f, indent=4, ensure_ascii=False)


def bootstrapNokiaSdwan(params, paramFile):
   print("Nokia VSD config to be added")



def decommissionCiscoSdwan():

   vmobj = rest_api_lib(vmanage_ip, vmanage_username, vmanage_password)
   print("Decommissioning vedge...") 
   response = vmobj.get_request("system/device/decommission/" + vedgeUuid)
   print("vedge decommissioned. Response : " + response) 

def decommissionNokiaSdwan():
   print("Nokia VSD config to be added")

if __name__ == "__main__":
    main()
