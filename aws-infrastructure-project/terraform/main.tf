provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
}

module "rds" {
  source = "./modules/rds"
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

output "s3_bucket_ids" {
  value = module.s3.bucket_ids
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}