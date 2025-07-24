region              = "us-east-1"
project             = "PROG8870"
owner               = "Pjebastian5480@conestogac.on.ca"

bucket1_name        = "prog8870-tf-9015480-usnv-s3-bucket1"
bucket2_name        = "prog8870-tf-9015480-usnv-s3-bucket2"
bucket3_name        = "prog8870-tf-9015480-usnv-s3-bucket3"
bucket4_name        = "prog8870-tf-9015480-usnv-s3-bucket4"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
az                  = "us-east-1a"

ami_id              = "ami-0c02fb55956c7d316"
instance_type       = "t2.micro"
key_name            = "PROG8870-KEY"

db_name             = "prog8870db"
db_username         = "admin"
db_password         = "StrongPass123!"
