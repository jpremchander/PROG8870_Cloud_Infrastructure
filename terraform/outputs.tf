output "s3_bucket_names" {
  value = [
    module.s3_bucket1.bucket_name,
    module.s3_bucket2.bucket_name,
    module.s3_bucket3.bucket_name,
    module.s3_bucket4.bucket_name
  ]
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

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
