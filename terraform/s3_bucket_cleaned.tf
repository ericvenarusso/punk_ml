resource "aws_s3_bucket" "bucket_cleaned" {
  bucket = "punk-cleaned-terraform"
  acl    = "private"
}