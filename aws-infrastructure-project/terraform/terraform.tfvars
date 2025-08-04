region = "us-east-1"

# S3 Bucket Names
s3_bucket_name_1 = "my-private-s3-bucket-1"
s3_bucket_name_2 = "my-private-s3-bucket-2"
s3_bucket_name_3 = "my-private-s3-bucket-3"
s3_bucket_name_4 = "my-private-s3-bucket-4"

# EC2 Instance Configuration
ami_id = "ami-0c55b159cbfafe1f0" # Example AMI ID, replace with a valid one
instance_type = "t2.micro"

# RDS Database Configuration
db_instance_class = "db.t3.micro"
db_name = "mydatabase"
db_username = "admin"
db_password = "password123" # Use a more secure method for sensitive data

# VPC Configuration
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidr_block = "10.0.1.0/24"
private_subnet_cidr_block = "10.0.2.0/24"