# Common
variable "region" {}
variable "project" {}
variable "owner" {}

# S3 Buckets
variable "bucket1_name" {}
variable "bucket2_name" {}
variable "bucket3_name" {}
variable "bucket4_name" {}

# VPC
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "az" {}

# EC2
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}

# RDS
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
