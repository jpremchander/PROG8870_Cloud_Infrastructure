variable "s3_bucket_names" {
  description = "List of S3 bucket names to create"
  type        = list(string)
}

variable "s3_versioning" {
  description = "Enable versioning for S3 buckets"
  type        = bool
  default     = false
}

variable "s3_bucket_tags" {
  description = "Tags to apply to the S3 buckets"
  type        = map(string)
  default     = {}
}