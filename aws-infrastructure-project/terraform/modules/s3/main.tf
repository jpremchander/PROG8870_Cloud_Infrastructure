resource "aws_s3_bucket" "private_bucket_1" {
  bucket = "my-private-bucket-1"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "private_bucket_2" {
  bucket = "my-private-bucket-2"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "private_bucket_3" {
  bucket = "my-private-bucket-3"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "private_bucket_4" {
  bucket = "my-private-bucket-4"
  acl    = "private"

  versioning {
    enabled = true
  }
}