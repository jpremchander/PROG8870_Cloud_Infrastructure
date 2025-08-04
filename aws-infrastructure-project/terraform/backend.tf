terraform {
  backend "s3" {
    bucket         = "your-unique-bucket-name"
    key            = "terraform/state"
    region         = "your-region"
    dynamodb_table = "your-lock-table"
    encrypt        = true
  }
}