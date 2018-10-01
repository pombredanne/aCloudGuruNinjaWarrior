##########################################################################
#create/delete VPCs in different regions for demo purposes
##########################################################################

import json
import boto3
import traceback
import datetime
import os
import time
import argparse

def main():
    
    print("Entered test client")

    createdVpcs = []
    delete = False
    create = True 

    parser = argparse.ArgumentParser()
    parser.add_argument('-D','--delete', help='Delete VPCs', required=False)
    args = vars(parser.parse_args())
    if args['delete'] == "true":
      delete = True
      create = False   
       
    
    try:

       ####################################
       #Create
       ####################################

       if create == True:
          with open("vpcs/demoVPCs.json") as f_in:
             params=json.load(f_in)
             #print(params)

          for vpcInput in params:
             print(vpcInput)
             vpcName = vpcInput['VPCName']
             print("Creating VPC ... ")
             ec2 = boto3.resource('ec2',region_name=vpcInput['Region']) 
             vpc = ec2.create_vpc(CidrBlock=vpcInput['CIDR'])
             vpc.create_tags(Tags=[{"Key": "Name", "Value": vpcName}]) 
             vpc.wait_until_available() 
             print(vpc.id) 
             vpcIdentifier = vpc.id
             print(vpcIdentifier)
             #createdVpcs.append(vpc.id)

             newVpc = {'VPCName': vpcInput['VPCName'], 'Region': vpcInput['Region'], 'CIDR': vpcInput['CIDR'], 'VPCID': vpcIdentifier  }
             createdVpcs.append(newVpc)

             ig = ec2.create_internet_gateway() 
             vpc.attach_internet_gateway(InternetGatewayId=ig.id) 
             #print(ig.id) 

             print("Created VPC")

             # now write output to a file
             print(createdVpcs)
             with open('vpcs/createdVpcs.json', 'w') as vpcFile :
                json.dump(createdVpcs, vpcFile, indent=4)
             vpcFile.close()

            

       ####################################
       #Delete
       ####################################
       if delete == True:
          with open("vpcs/createdVpcs.json") as f_in:
             params=json.load(f_in)
             #print(params)

          for vpcInput in params:
             print(vpcInput)
             vpcId = vpcInput['VPCID']
             print("Deleting VPC ... ")
             ec2 = boto3.resource('ec2',region_name=vpcInput['Region'])
             ec2client = ec2.meta.client

             vpc = ec2.Vpc(vpcId) 
             for gw in vpc.internet_gateways.all(): 
                vpc.detach_internet_gateway(InternetGatewayId=gw.id) 
                gw.delete() 

             ec2client.delete_vpc(VpcId=vpcId)

             print("Deleted VPC")





    except Exception as e: 
       print("ERROR: ")
       traceback.print_exc()


if __name__ == "__main__":
    main()
