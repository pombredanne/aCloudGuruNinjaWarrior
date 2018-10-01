##########################################################################
#runTests - create series of pcsn stacks uding different json param files
##########################################################################
#future - put region in file name to specific region for each test (need to do when creating client
#future - use file name to denote if create or update
#future - pass option to run single test
#future - pass option to abort/continue on test failure

import json
import boto3
import traceback
import datetime
import os
import time
import argparse

def main():
    
    print("Entered test client")

    results = []
    stackName = "devtestPCSNFoundation"
    retryGap = 30
    status=""

    parser = argparse.ArgumentParser()
    parser.add_argument('-D','--deleteAfterCreate', help='Delete stack once created', required=False)
    args = vars(parser.parse_args())
    if args['deleteAfterCreate'] == "false":
      deleteAfterCreate = False
    else:
      deleteAfterCreate = True
       
    
    try:

       client = boto3.client('cloudformation')


       ####################################
       #Get test params
       ####################################

       for file in os.listdir("testparams"):
          #filename = os.fsdecode(file)
          if file.endswith(".json"): 
             print("------------------")
             print("TEST: " + file )
             print("------------------")

             with open("testparams/"+file) as f_in:
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
             client = boto3.client('cloudformation',aws_access_key_id=credentials["AccessKeyId"],aws_secret_access_key=credentials["SecretAccessKey"],aws_session_token=credentials["SessionToken"])
             print("Logged on")
            

       ####################################
       #Create stack
       ####################################
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
             if deleteAfterCreate == True:
                print("Deleting stack ...")
                stack = client.delete_stack(StackName=stackName)
                print("Stack deleted initiated")
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
                   

       #Print results
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


if __name__ == "__main__":
    main()
