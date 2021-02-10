resource "aws_s3_bucket" "bucket_raw" {
  bucket = "punk-raw-terraform"
  acl    = "private"
}