resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "punk-terraform"
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "beers-terraform"
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://punk-cleaned-terraform/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      name                  = "my-stream"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"

      parameters = {
        "serialization.format" = 1
      }
    }

    columns {
      name = "id"
      type = "int"
    }

    columns {
      name = "name"
      type = "string"
    }

    columns {
      name    = "ibu"
      type    = "float"
    }

    columns {
      name    = "target_fg"
      type    = "float"
    }

    columns {
      name    = "target_og"
      type    = "float"
    }

    columns {
      name    = "ebc"
      type    = "float"
    }

    columns {
      name    = "srm"
      type    = "float"
    }

    columns {
      name    = "ph"
      type    = "float"
    }
  }
}