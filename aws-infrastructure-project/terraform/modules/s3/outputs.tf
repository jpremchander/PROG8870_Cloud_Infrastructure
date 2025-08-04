output "s3_bucket_names" {
  value = [
    aws_s3_bucket.bucket1.id,
    aws_s3_bucket.bucket2.id,
    aws_s3_bucket.bucket3.id,
    aws_s3_bucket.bucket4.id,
  ]
}

output "s3_bucket_versioning" {
  value = [
    aws_s3_bucket.bucket1.versioning[0].enabled,
    aws_s3_bucket.bucket2.versioning[0].enabled,
    aws_s3_bucket.bucket3.versioning[0].enabled,
    aws_s3_bucket.bucket4.versioning[0].enabled,
  ]
}