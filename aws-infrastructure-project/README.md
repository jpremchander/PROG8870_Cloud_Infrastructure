# AWS Infrastructure Automation with Terraform and CloudFormation

## Project Overview
This project demonstrates the automation of AWS infrastructure deployment using Terraform and CloudFormation. It includes the creation of a scalable multi-service environment featuring S3 Buckets, EC2 Instances, and RDS Database Instances, adhering to Infrastructure as Code (IaC) best practices.

## Project Structure
The project is organized into the following directories:

- **terraform/**: Contains all Terraform configuration files and modules.
- **cloudformation/**: Contains CloudFormation templates and parameter files.
- **scripts/**: Contains deployment scripts for Terraform and CloudFormation.
- **docs/**: Contains documentation files, including presentation slides.
- **screenshots/**: Contains screenshots of the deployed resources.
- **README.md**: This documentation file.

## Setup Instructions

### Prerequisites
- An AWS account.
- AWS CLI installed and configured with appropriate permissions.
- Terraform installed on your local machine.
- Access to a terminal or command prompt.

### Terraform Deployment
1. Navigate to the `terraform` directory:
   ```
   cd terraform
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Review the planned changes:
   ```
   terraform plan
   ```

4. Apply the Terraform configuration:
   ```
   terraform apply
   ```

### CloudFormation Deployment
1. Navigate to the `cloudformation` directory:
   ```
   cd cloudformation
   ```

2. Deploy the CloudFormation stacks using the AWS CLI:
   ```
   aws cloudformation create-stack --stack-name <stack-name> --template-body file://<template-file> --parameters file://<params-file>
   ```

## Resource Overview
- **S3 Buckets**: Created using both Terraform and CloudFormation, configured for private access with versioning enabled.
- **EC2 Instances**: Deployed within a custom VPC, with public IPs and SSH access configured.
- **RDS Instances**: MySQL database instances created with public access for demonstration purposes.

## Key Features
- Modular and reusable Terraform and CloudFormation configurations.
- Dynamic variable management to avoid hardcoding values.
- Comprehensive documentation to facilitate replication of the setup.

## Challenges Encountered
- Ensuring proper IAM permissions for resource creation.
- Managing state files for Terraform effectively.

## Live Demo
A live demonstration will showcase:
- The execution of Terraform and CloudFormation commands.
- The resources created in the AWS Management Console.

## Conclusion
This project exemplifies the use of Infrastructure as Code to automate AWS resource provisioning, ensuring best practices in security, modularity, and documentation.