variable "function_name_raw" {
  type = string
  default = "punk_raw_terraform"
}

resource "aws_lambda_function" "lambda_raw" {
  filename      = "lambda/${var.function_name_raw}.zip"
  function_name = "${var.function_name_raw}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("lambda/${var.function_name_raw}.zip")

  runtime = "python3.7"
}

