
resource "aws_iam_role" "crawler_lambda_executor" {
  name                    = "crawler_lambda_executor"
  assume_role_policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      }
    },
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lanyrd_crawler_function" {
  s3_bucket               = "${aws_s3_bucket.dev_events_code.bucket}"
  s3_key                  = "crawler.zip"
  function_name           = "lanyrd_crawler_function"
  description             = "Crawl single event from Lanyrd to dev.events database"
  role                    = "${aws_iam_role.crawler_lambda_executor.arn}"
  handler                 = "crawler"
  runtime                 = "nodejs6.10"
  memory_size             = "128"
  timeout                 = "300"
}

resource "aws_lambda_alias" "lanyrd_crawler_function" {
  name                    = "lanyrd_crawler_function_latest"
  function_name           = "${aws_lambda_function.lanyrd_crawler_function.arn}"
  function_version        = "$LATEST"
}
