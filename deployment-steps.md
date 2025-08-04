# PROG8870 Final Project - Deployment Steps

**Student:** Prem Chander J  
**Student ID:** 9015480  
**Email:** Pjebastian5480@conestogac.on.ca  

## Pre-Deployment Setup

### 1. AWS CLI Configuration
```bash
# Configure AWS CLI with your credentials
aws configure
# Enter your:
# AWS Access Key ID: [Your AWS Access Key]
# AWS Secret Access Key: [Your AWS Secret Key]
# Default region name: us-east-1
# Default output format: json
```

### 2. Create Key Pair in AWS
```bash
# Create key pair using AWS CLI
aws ec2 create-key-pair --key-name PROG8870-KEY --query 'KeyMaterial' --output text > PROG8870-KEY.pem

# Set proper permissions
chmod 400 PROG8870-KEY.pem

# OR create via AWS Console:
# Go to EC2 > Key Pairs > Create Key Pair > Name: PROG8870-KEY
```

### 3. Verify Prerequisites
```bash
# Check Terraform version
terraform --version
# Should show: Terraform v1.0+

# Check AWS CLI version
aws --version
# Should show: aws-cli/2.x.x

# Test AWS connectivity
aws sts get-caller-identity
# Should return your account details
```

## Terraform Deployment Steps

### Step 1: Navigate to Terraform Directory
```bash
cd terraform
```

### Step 2: Update terraform.tfvars File
Open `terraform.tfvars` and verify/update these values:
```hcl
aws_region = "us-east-1"
student_id = "9015480"
owner_email = "Pjebastian5480@conestogac.on.ca"

# S3 Configuration
s3_bucket_count = 4

# EC2 Configuration
instance_type = "t2.micro"
ami_id = "ami-0c02fb55956c7d316"  # Update for your region if needed

# RDS Configuration
db_instance_class = "db.t3.micro"
db_name = "prog8870db"
db_username = "admin"
db_password = "SecurePassword123!"  # CHANGE THIS PASSWORD

# VPC Configuration
vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
```

### Step 3: Initialize Terraform
```bash
terraform init
```
**Expected Output:**
```
Initializing modules...
Initializing the backend...
Initializing provider plugins...
Terraform has been successfully initialized!
```

### Step 4: Validate Configuration
```bash
terraform validate
```
**Expected Output:**
```
Success! The configuration is valid.
```

### Step 5: Format Code
```bash
terraform fmt
```

### Step 6: Plan Deployment
```bash
terraform plan -var-file="terraform.tfvars"
```
**Input Required:** None (all variables are in tfvars file)
**Expected Output:** Plan showing resources to be created

### Step 7: Apply Configuration
```bash
terraform apply -var-file="terraform.tfvars"
```
**Input Required:** 
- Type `yes` when prompted: `Do you want to perform these actions? (yes/no):`

**Expected Duration:** 5-10 minutes

### Step 8: View Outputs
```bash
terraform output
```

## CloudFormation Deployment Steps

### Step 1: Navigate to CloudFormation Directory
```bash
cd ../cloudformation
```

### Step 2: Update Parameter Files (if needed)
Check and update these files with your specific values:

**vpc/params.json:**
```json
[
  {
    "ParameterKey": "StudentId",
    "ParameterValue": "9015480"
  },
  {
    "ParameterKey": "OwnerEmail",
    "ParameterValue": "Pjebastian5480@conestogac.on.ca"
  }
]
```

**rds/params.json:**
```json
[
  {
    "ParameterKey": "DBPassword",
    "ParameterValue": "YourSecurePassword123"  // CHANGE THIS
  }
]
```

### Step 3: Deploy VPC Stack
```bash
aws cloudformation create-stack \
    --stack-name PROG8870-VPC-Stack \
    --template-body file://vpc/template.json \
    --parameters file://vpc/params.json \
    --region us-east-1
```
**Input Required:** None
**Wait for completion:**
```bash
aws cloudformation wait stack-create-complete --stack-name PROG8870-VPC-Stack
```

### Step 4: Deploy S3 Stack
```bash
aws cloudformation create-stack \
    --stack-name PROG8870-S3-Stack \
    --template-body file://s3/template.json \
    --parameters file://s3/params.json \
    --region us-east-1
```
**Wait for completion:**
```bash
aws cloudformation wait stack-create-complete --stack-name PROG8870-S3-Stack
```

### Step 5: Deploy EC2 Stack
```bash
aws cloudformation create-stack \
    --stack-name PROG8870-EC2-Stack \
    --template-body file://ec2/template.json \
    --parameters file://ec2/params.json \
    --region us-east-1
```
**Wait for completion:**
```bash
aws cloudformation wait stack-create-complete --stack-name PROG8870-EC2-Stack
```

### Step 6: Deploy RDS Stack
```bash
aws cloudformation create-stack \
    --stack-name PROG8870-RDS-Stack \
    --template-body file://rds/template.json \
    --parameters file://rds/params.json \
    --region us-east-1
```
**Wait for completion:**
```bash
aws cloudformation wait stack-create-complete --stack-name PROG8870-RDS-Stack
```

## Using Automated Scripts

### Option 1: Terraform Script
```bash
# From project root directory
chmod +x scripts/deploy-terraform.sh
./scripts/deploy-terraform.sh
```
**Input Required:**
- Type `yes` when prompted to apply changes

### Option 2: CloudFormation Script
```bash
# From project root directory
chmod +x scripts/deploy-cloudformation.sh
./scripts/deploy-cloudformation.sh
```
**Input Required:** None (fully automated)

## Verification Steps

### 1. Check Terraform Resources
```bash
cd terraform
terraform output
```

### 2. Check CloudFormation Stacks
```bash
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE
```

### 3. Verify in AWS Console
- **EC2 Dashboard:** Check instances
- **S3 Console:** Verify buckets
- **RDS Console:** Check database instances
- **VPC Console:** Verify networking components

### 4. Test EC2 Web Server
```bash
# Get EC2 public IP from Terraform output
EC2_IP=$(terraform output -raw ec2_public_ip)
curl http://$EC2_IP

# Or get from CloudFormation
EC2_IP=$(aws cloudformation describe-stacks --stack-name PROG8870-EC2-Stack --query 'Stacks[0].Outputs[?OutputKey==`PublicIP`].OutputValue' --output text)
curl http://$EC2_IP
```

### 5. Test SSH Access
```bash
# Using Terraform EC2
ssh -i PROG8870-KEY.pem ec2-user@<TERRAFORM_EC2_IP>

# Using CloudFormation EC2
ssh -i PROG8870-KEY.pem ec2-user@<CLOUDFORMATION_EC2_IP>
```

## Demo Presentation Steps

### 1. Show Code Structure
```bash
tree aws-infrastructure-project/
```

### 2. Demonstrate Terraform
```bash
cd terraform
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
# Type: yes
terraform output
```

### 3. Demonstrate CloudFormation
```bash
cd ../cloudformation
aws cloudformation create-stack --stack-name DEMO-VPC --template-body file://vpc/template.json --parameters file://vpc/params.json
aws cloudformation describe-stacks --stack-name DEMO-VPC
```

### 4. Show AWS Console
- Navigate to each service (EC2, S3, RDS, VPC)
- Show created resources with proper naming
- Demonstrate tags and configurations

### 5. Test Connectivity
```bash
# Show web server response
curl http://<EC2_PUBLIC_IP>

# Show SSH access
ssh -i PROG8870-KEY.pem ec2-user@<EC2_PUBLIC_IP>
```

## Cleanup Steps

### Terraform Cleanup
```bash
cd terraform
terraform destroy -var-file="terraform.tfvars"
# Type: yes when prompted
```

### CloudFormation Cleanup
```bash
# Delete in reverse order (dependencies)
aws cloudformation delete-stack --stack-name PROG8870-RDS-Stack
aws cloudformation delete-stack --stack-name PROG8870-EC2-Stack
aws cloudformation delete-stack --stack-name PROG8870-S3-Stack
aws cloudformation delete-stack --stack-name PROG8870-VPC-Stack
```

## Troubleshooting Common Issues

### Issue 1: Key Pair Not Found
```bash
# Create the key pair
aws ec2 create-key-pair --key-name PROG8870-KEY --query 'KeyMaterial' --output text > PROG8870-KEY.pem
chmod 400 PROG8870-KEY.pem
```

### Issue 2: AMI Not Available in Region
```bash
# Find latest Amazon Linux 2 AMI for your region
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*" --query 'Images[*].[ImageId,CreationDate]' --output text | sort -k2 -r | head -5
```

### Issue 3: Bucket Name Already Exists
Update the student ID in terraform.tfvars or params.json to make bucket names unique.

### Issue 4: CloudFormation Stack Creation Failed
```bash
# Check stack events for error details
aws cloudformation describe-stack-events --stack-name STACK-NAME
```

### Issue 5: Terraform State Lock
```bash
# If state is locked, force unlock (use carefully)
terraform force-unlock LOCK_ID
```

## Expected Resource Names After Deployment

### Terraform Resources
- S3 Buckets: `prog8870-tf-9015480-usnv-s3-bucket1` to `bucket4`
- EC2 Instance: `PROG8870-TF-USNV-EC2`
- RDS Instance: `prog8870-tf-usnv-rds`
- VPC: `PROG8870-TF-USNV-VPC`

### CloudFormation Resources
- S3 Buckets: `prog8870-cft-9015480-usnv-s3-bucket1` to `bucket3`
- EC2 Instance: `PROG8870-CFT-USNV-EC2`
- RDS Instance: `prog8870-cft-usnv-rds`
- VPC: `PROG8870-CFT-USNV-VPC`

## Demo Timeline (10 minutes)
1. **Introduction (1 min):** Project overview and architecture
2. **Code Walkthrough (2 min):** Show directory structure and key files
3. **Terraform Demo (3 min):** Run terraform plan and apply
4. **CloudFormation Demo (2 min):** Deploy one stack, show in console
5. **AWS Console Tour (1.5 min):** Show created resources
6. **Testing (0.5 min):** Access web server, show connectivity

---
**Note:** Always use secure passwords and follow your organization's security policies. This deployment guide is for educational purposes in the PROG8870