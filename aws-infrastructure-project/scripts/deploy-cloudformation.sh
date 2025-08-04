#!/bin/bash

# This script automates the deployment of CloudFormation stacks for the AWS infrastructure.

# Set the AWS region
AWS_REGION="us-east-1"

# Deploy S3 CloudFormation stack
aws cloudformation create-stack --stack-name S3Stack --template-body file://cloudformation/s3/template.json --parameters file://cloudformation/s3/params.json --region $AWS_REGION

# Deploy EC2 CloudFormation stack
aws cloudformation create-stack --stack-name EC2Stack --template-body file://cloudformation/ec2/template.json --parameters file://cloudformation/ec2/params.json --region $AWS_REGION

# Deploy RDS CloudFormation stack
aws cloudformation create-stack --stack-name RDSStack --template-body file://cloudformation/rds/template.json --parameters file://cloudformation/rds/params.json --region $AWS_REGION

# Deploy VPC CloudFormation stack
aws cloudformation create-stack --stack-name VPCStack --template-body file://cloudformation/vpc/template.json --parameters file://cloudformation/vpc/params.json --region $AWS_REGION

echo "CloudFormation stacks have been initiated."