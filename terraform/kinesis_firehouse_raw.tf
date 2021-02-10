resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream_raw" {
  name        = "punk_firehouse_raw_terraform"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.bucket_raw.arn
    buffer_size     = 1
    buffer_interval = 60
  }

  kinesis_source_configuration {
    role_arn = aws_iam_role.firehose_role.arn
    kinesis_stream_arn = aws_kinesis_stream.kinesis_stream.arn
  }

}
