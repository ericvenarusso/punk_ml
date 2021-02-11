resource "aws_cloudwatch_event_rule" "every_five_minutes" {
    name = "punk-every-five-minutes-schedule"
    description = "Fires every five minutes"
    schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "scheduler" {
    rule = "${aws_cloudwatch_event_rule.every_five_minutes.name}"
    target_id = "lambda_raw"
    arn = "${aws_lambda_function.lambda_raw.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda_raw.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.every_five_minutes.arn}"
}