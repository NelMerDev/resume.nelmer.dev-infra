module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0.1"

  name = var.vpc_name
  cidr = var.cidr_block

  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  # private_subnets = ["10.0.100.0/20", "10.0.116.0/20", "10.0.132.0/20"]

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    ManagedBy = "Terraform"
    Project   = "resume.nelmer.dev"
  }
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  vpc_id = module.vpc.vpc_id
  name   = var.sg_name

  tags = {
    ManagedBy = "Terraform"
    Project   = "resume.nelmer.dev"
  }
}

module "dynamodb-table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.4.0"

  name           = "VisitorCounter"
  table_class    = "STANDARD"
  hash_key       = "id"
  read_capacity  = 0
  write_capacity = 0
  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]

  tags = {
    ManagedBy = "Terraform"
    Project   = "resume.nelmer.dev"
  }
}

module "apigateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "5.3.0"

  name                         = "VisitorCounter"
  description                  = "Calls lambda VisitorCounter and tracks visitor counts in dynamodb table"
  protocol_type                = "HTTP"
  ip_address_type              = "ipv4"
  api_key_selection_expression = "$request.header.x-api-key"
  create_domain_name           = false
  create_domain_records        = false

  routes = {
    "GET /" = {
      detailed_metrics_enabled = false
      integration = {
        type                   = "AWS_PROXY"
        uri                    = module.visitor_counter_lambda.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 30000
      }
    }
  }

  tags = {
    ManagedBy = "Terraform"
    Project   = "resume.nelmer.dev"
  }
}

module "visitor_counter_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.0.1"

  function_name                           = "VisitorCounter"
  description                             = "Updates dynamodb table when api is triggered"
  handler                                 = "lambda_function.lambda_handler"
  runtime                                 = "python3.13"
  publish                                 = false
  create_current_version_allowed_triggers = false

  source_path = "${path.module}/lambda_functions/VisitorCounter"

  environment_variables = {
    BUCKET_NAME = "resume.nelmer.dev"
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow"
      actions   = ["dynamodb:UpdateItem", "dynamodb:GetItem", "dynamodb:PutItem"]
      resources = ["arn:aws:dynamodb:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:table/VisitorCounter"]
    }
  }

  allowed_triggers = {
    APIGatewayAllowInvoke = {
      service    = "apigateway"
      source_arn = "${module.apigateway.api_execution_arn}/*/GET/"
    }
  }

  tags = {
    ManagedBy = "Terraform"
    Project   = "resume.nelmer.dev"
  }
}

module "cloudflare_s3_policy_updater_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.0.1"

  function_name = "CloudflareS3PolicyUpdater"
  description   = "Updates the S3 bucket policy using Cloudflare's public IPs"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.13"
  publish       = true

  source_path = "${path.module}/lambda_functions/CloudflareS3Policy"

  environment_variables = {
    BUCKET_NAME = "resume.nelmer.dev"
  }

  attach_policy_statements = true
  policy_statements = {
    PutResumeBucketPolicy = {
      effect    = "Allow"
      actions   = ["s3:PutBucketPolicy"]
      resources = ["arn:${data.aws_partition.current.partition}:s3:::resume.nelmer.dev"]
    }
  }
  allowed_triggers = {
    from_eventbridge = {
      principal  = "events.amazonaws.com"
      source_arn = "arn:aws:events:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:rule/cloudflare-s3-updater"
    }
  }

  tags = {
    ManagedBy = "Terraform"
    Project   = "resume.nelmer.dev"
  }
}

module "eventbridge" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "4.1.0"

  create_bus = true
  bus_name   = "cloudflare-updater-bus"

  attach_lambda_policy = true
  lambda_target_arns   = [module.cloudflare_s3_policy_updater_lambda.lambda_function_arn]

  schedule_groups = {
    cloudflare = {
      name_prefix = "cloudflare-updater-"
    }
  }

  schedules = {
    cloudflare_s3_updater = {
      group_name          = "cloudflare"
      name                = "cloudflare-s3-updater"
      description         = "Invoke Lambda to update Cloudflare IPs on S3 policy"
      schedule_expression = "rate(24 hours)"
      timezone            = "UTC-04:00"
      arn                 = module.cloudflare_s3_policy_updater_lambda.lambda_function_arn
      input               = jsonencode({})
    }
  }
}


module "s3-nelmer" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"

  bucket        = "nelmer.dev"
  create_bucket = true

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    ManagedBy = "Terraform"
    Name      = "nelmer.dev"
  }
}

module "s3-resume" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"

  bucket        = "resume.nelmer.dev"
  create_bucket = true

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    ManagedBy = "Terraform"
    Name      = "resume.nelmer.dev"
  }
}
