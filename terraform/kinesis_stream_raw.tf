resource "aws_kinesis_stream" "kinesis_stream" {
  name             = "punk_data_stream_terraform"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}