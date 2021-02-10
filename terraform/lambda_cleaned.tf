variable "function_name_cleaned" {
  type = string
  default = "punk_cleaned_terraform"
}

resource "aws_lambda_function" "lambda_cleaned" {
  filename      = "lambda/${var.function_name_cleaned}.zip"
  function_name = "${var.function_name_cleaned}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("lambda/${var.function_name_cleaned}.zip")

  runtime = "python3.7"
}

