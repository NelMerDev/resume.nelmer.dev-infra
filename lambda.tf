# import {
#   to = aws_lambda_function.VisitorCounterFunction
#   id = "VisitorCounterFunction"
# }

# Step 1: Automatically zip the Lambda source code using archive_file
data "archive_file" "VisitorCounterFunction" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_functions/VisitorCounterFunction"
  output_path = "${path.module}/lambda_functions/VisitorCounterFunction.zip"
}

# Step 2: Define the VisitorCounterFunction Lambda using the zipped source
resource "aws_lambda_function" "VisitorCounterFunction" {
  filename      = data.archive_file.VisitorCounterFunction.output_path
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

  depends_on = [data.archive_file.VisitorCounterFunction]
}

# import {
#   to = aws_lambda_function.CloudflareS3Policy
#   id = "resume-nelmer-dev-SetBucketPolicy"
# }

# Step 1: Automatically zip the Lambda source code using archive_file
data "archive_file" "CloudflareS3Policy" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_functions/CloudflareS3Policy"
  output_path = "${path.module}/lambda_functions/CloudflareS3Policy.zip"
}
# Step 2: Define the VisitorCounterFunction Lambda using the zipped source
resource "aws_lambda_function" "CloudflareS3Policy" {
  filename      = data.archive_file.CloudflareS3Policy.output_path
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
  depends_on = [data.archive_file.CloudflareS3Policy]
}