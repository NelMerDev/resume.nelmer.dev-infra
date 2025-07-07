# import {
#   to = aws_iam_role.VisitorCounterFunction-role
#   id = "VisitorCounterFunction-role-k9zbarxs"
# }
resource "aws_iam_role" "VisitorCounterFunction-role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "VisitorCounterFunction-role-k9zbarxs"
  path                  = "/service-role/"
  tags = {
    ManagedBy = "Terraform"
  }
}

# import {
#   to = aws_iam_role.CloudflareS3Policy-role
#   id = "resume-nelmer-dev-SetBucketPolicy-role-i244yeso"
# }
resource "aws_iam_role" "CloudflareS3Policy-role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "resume-nelmer-dev-SetBucketPolicy-role-i244yeso"
  name_prefix           = null
  path                  = "/service-role/"
  tags = {
    ManagedBy = "Terraform"
  }
}

import {
  to = aws_iam_role.CloudflareS3PolicyScheduler-role
  id = "Amazon_EventBridge_Scheduler_LAMBDA_1ef2945785"
}
resource "aws_iam_role" "CloudflareS3PolicyScheduler-role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = "393679160576"
        }
      }
      Effect = "Allow"
      Principal = {
        Service = "scheduler.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "Amazon_EventBridge_Scheduler_LAMBDA_1ef2945785"
  path                  = "/service-role/"
  tags = {
    ManagedBy = "Terraform"
  }
}