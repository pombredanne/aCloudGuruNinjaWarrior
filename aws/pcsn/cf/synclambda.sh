#!/bin/bash

aws s3 sync s3://btdynspcsn-eu-west-2  s3://btdynspcsn-us-east-1
aws s3 sync s3://btdynspcsn-eu-west-2  s3://btdynspcsn-us-east-2
aws s3 sync s3://btdynspcsn-eu-west-2  s3://btdynspcsn-ap-south-1
aws s3 sync s3://btdynspcsn-eu-west-2  s3://btdynspcsn-eu-central-1



