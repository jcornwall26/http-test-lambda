resource "aws_lambda_function" "http_test_lambda" {
  function_name = format("%s-%s-%s", "http_test_lambda", var.suffix, var.pagerduty_key)
  role          = aws_iam_role.http_test_lambda_role.arn
  image_uri     = var.image_uri
  package_type  = "Image"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "http_test_lambda_role" {
  name               = "http_test_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name = "http_test_lambda_policy_inline"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}