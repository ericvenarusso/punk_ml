resource "aws_iam_role" "firehose_role" {
  name = "firehose_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kineses-full-acess-policy-attachment-firehouse" {
    role = "${aws_iam_role.firehose_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3-full-acess-policy-attachment" {
    role = "${aws_iam_role.firehose_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "glue-full-acess-policy-attachment" {
    role = "${aws_iam_role.firehose_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda-full-acess-policy-attachment" {
    role = "${aws_iam_role.firehose_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name_raw}_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kineses-full-acess-policy-attachment-lambda" {
    role = "${aws_iam_role.lambda_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}