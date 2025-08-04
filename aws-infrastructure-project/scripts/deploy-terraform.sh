#!/bin/bash

# Navigate to the Terraform directory
cd ../terraform

# Initialize Terraform
terraform init

# Validate the Terraform configuration
terraform validate

# Plan the Terraform deployment
terraform plan

# Apply the Terraform configuration
terraform apply -auto-approve

# Output the results
echo "Terraform deployment completed."