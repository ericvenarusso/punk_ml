resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream_cleaned" {
  name        = "punk_firehouse_cleaned_terraform"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket_cleaned.arn
    buffer_size     = 64
    buffer_interval = 60

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.lambda_cleaned.arn}:$LATEST"
        }
      }
    }

    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          open_x_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          parquet_ser_de {}
        }
      }

      schema_configuration {
        database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
        role_arn      = aws_iam_role.firehose_role.arn
        table_name    = aws_glue_catalog_table.aws_glue_catalog_table.name
        region        = "us-east-1"
      }
    }
  }

  kinesis_source_configuration {
    role_arn = aws_iam_role.firehose_role.arn
    kinesis_stream_arn = aws_kinesis_stream.kinesis_stream.arn
  }
}
