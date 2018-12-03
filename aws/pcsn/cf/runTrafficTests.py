##########################################################################
#run networks tests and diagnostics checks upon failure
##########################################################################

import json
import boto3
import traceback
import datetime
import os
import time
import argparse
import subprocess
from netaddr import CIDR, IP

def main():
    
    print("Entered traffic testing")

    diagnosticsChecks = []
    allTestResults = []
    runSingleTest = False
    runAllTests = True 

    ##Read arguments

    parser = argparse.ArgumentParser()
    parser.add_argument('-S','--runSingleTest', help='Run single on demand test', required=False)
    args = vars(parser.parse_args())
    if args['runSingleTest'] == "true":
      runSingleTest = True
      runAllTests = False   
       
    
    try:

       ####################################
       #Run all tests
       ####################################

       if runAllTests == True:
          with open("trafficTests/ttests.json") as f_in:
             ttests=json.load(f_in)
             #print(params)

          for ttest in ttests:
             print("Running Traffic Test ... ")
             print(ttest)

             name = ttest['TestName']
             protocol = ttest['TestProtocol']
             target = ttest['TestEndPointTarget']

             if protocol == "ping":
                testResult = runPingTest(target)
             elif protocol == "iperf":
                testResult = runIPerfTest(target)
             else:
                raise Exception("Unknown traffic test protocol " + protocol)


             result = testResult['Result']             
             details = testResult['Details']             

             if result == "FAIL":
                diagnostics = runDiagnostics(target)
                testResultDetails = {'TestName': name, 'TestProtocol': protocol, 'TestEndPointTarget': target, 'TestResult': result, 'Details': details, 'Diagnostics': diagnostics}
             else:
                testResultDetails = {'TestName': name, 'TestProtocol': protocol, 'TestEndPointTarget': target, 'TestResult': result, 'Details': details, 'Diagnostics': "N/A"}

             allTestResults.append(testResultDetails)


             print("Traffic Test Completed")

             ##now testresult output to a file
             with open('trafficTests/ttestResults.json', 'w') as ttestResultsFile :
                json.dump(allTestResults, ttestResultsFile, indent=4)
                ttestResultsFile.close()

            

       ####################################
       #Single on demand test- TBD
       ####################################


    except Exception as e: 
       print("ERROR: ")
       traceback.print_exc()



def runPingTest(target):

   print("Pinging " + target + " ...")
   detailsFile = "trafficTests/lastTestOutput.txt"

   response = os.system("ping -c 3 > " + detailsFile + " " + target)
   if response == 0:
      result = "PASS"
   else:
      result = "FAIL"

   with open(detailsFile, 'r') as myfile:
      details=myfile.read().replace('\n', ',')

   return {'Result': result, 'Details': details}


def runIperfTest(target):

   response = os.system("iperf -c " + target + " -t 10 -i 2 > " + detailsFile + " " + target)
   #tbd - may need to check on something like "connect failed" to determine if this was successful
   #tbd - put in threshold rule in test. If performance is lower then make this fail 
   if response == 0:
      result = "PASS"
   else:
      result = "FAIL"

   with open(detailsFile, 'r') as myfile:
      details=myfile.read().replace('\n', ',')

   return {'Result': test, 'Details': details}

def runDiagnostics(target):
   #tbd logic here
   
   #checks:
   #local route to vnf is present and active
   #remote route to vnf is present and active

   ##check local route

   #tbd - get subnet associated with this instance and then get route table
  
   #if IP("192.168.0.1") in CIDR("192.168.0.0/24"):
   if IP(target) in CIDR("192.168.0.0/24"):
    print "Yay!"

   #tbd - how to get instance id of devices. may need to get from dyd

   return {'Check1': "blah", 'Check2': "blah"}




if __name__ == "__main__":
    main()
