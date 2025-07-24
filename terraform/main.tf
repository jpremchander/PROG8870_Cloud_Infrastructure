// Root main.tf for deploying S3, EC2, VPC, RDS using modules

module "vpc" {
  source              = "./modules/vpc"
  project             = var.project
  owner               = var.owner
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "s3_bucket1" {
  source      = "./modules/s3"
  bucket_name = var.bucket1_name
  project     = var.project
  owner       = var.owner
}

module "s3_bucket2" {
  source      = "./modules/s3"
  bucket_name = var.bucket2_name
  project     = var.project
  owner       = var.owner
}

module "s3_bucket3" {
  source      = "./modules/s3"
  bucket_name = var.bucket3_name
  project     = var.project
  owner       = var.owner
}

module "s3_bucket4" {
  source      = "./modules/s3"
  bucket_name = var.bucket4_name
  project     = var.project
  owner       = var.owner
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.ec2_sg_id
  project       = var.project
  owner         = var.owner
}

module "rds" {
  source         = "./modules/rds"
  db_name        = var.db_name
  username       = var.db_username
  password       = var.db_password
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  sg_id          = module.vpc.rds_sg_id
  project        = var.project
  owner          = var.owner
}
