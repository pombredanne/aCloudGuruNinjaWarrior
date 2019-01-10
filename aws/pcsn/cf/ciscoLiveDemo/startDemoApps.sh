#!/bin/bash

aws ec2 start-instances --region us-east-1 --instance-ids i-0607495d4865ac6a5 
aws ec2 start-instances --region us-east-2 --instance-ids i-0e9ff2c3d3c201612  
aws ec2 start-instances --region ap-south-1 --instance-ids i-061af9c2e3412eb97  
aws ec2 start-instances --region eu-central-1 --instance-ids i-069dc686837671dd9 

