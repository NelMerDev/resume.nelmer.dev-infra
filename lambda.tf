# import {
#   to = aws_lambda_function.VisitorCounterFunction
#   id = "VisitorCounterFunction"
# }
resource "aws_lambda_function" "VisitorCounterFunction" {
  filename      = "${path.module}/lambda_functions/VisitorCounterFunction.zip"
  function_name = "VisitorCounterFunction"
  handler       = "lambda_function.lambda_handler"
  role          = "arn:aws:iam::393679160576:role/service-role/VisitorCounterFunction-role-k9zbarxs"
  runtime       = "python3.13"
  environment {
    variables = {
      TABLE_NAME = "VisitorCount"
    }
  }
  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/VisitorCounterFunction"
  }
  tags = {
    ManagedBy    = "Terraform"
    TargetBucket = "resume.nelmer.dev"
  }
}

# import {
#   to = aws_lambda_function.CloudflareS3Policy
#   id = "resume-nelmer-dev-SetBucketPolicy"
# }
resource "aws_lambda_function" "CloudflareS3Policy" {
  filename      = "${path.module}/lambda_functions/CloudflareS3Policy.zip"
  function_name = "resume-nelmer-dev-SetBucketPolicy"
  handler       = "lambda_function.lambda_handler"
  role          = "arn:aws:iam::393679160576:role/service-role/resume-nelmer-dev-SetBucketPolicy-role-i244yeso"
  runtime       = "python3.13"
  environment {
    variables = {
      BUCKET_NAME = "resume.nelmer.dev"
    }
  }
  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/resume-nelmer-dev-SetBucketPolicy"
  }
  tags = {
    ManagedBy    = "Terraform"
    TargetBucket = "resume.nelmer.dev"
  }
}