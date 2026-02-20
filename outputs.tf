# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "sg_id" {
#   value = module.security-group.security_group_id
# }

output "visitor-counter_function_arn" {
  value = module.visitor_counter_lambda.lambda_function_arn
}

output "cloudflare_function_arn" {
  value = module.cloudflare_s3_policy_updater_lambda.lambda_function_arn
}

output "eventbridge_rule_arns" {
  value = module.eventbridge.eventbridge_rule_arns
}

# output "cloudflare_s3_role_arn" {
#   value = module.cloudflare_s3_role.iam_role_arn
# }

# output "cloudflare_s3_role_name" {
#   value = module.cloudflare_s3_role.iam_role_name
# }

# output "lambda_cloudwatch_logs" {
#   value = module.lambda_cloudwatch_logs.arn
# }

# output "s3_cloudflare_policy_updater" {
#   value = module.s3_cloudflare_policy_updater.arn
# }

# output "dynamodb_table_visitor_count" {
#   value = module.dynamodb_table_visitorcount.arn
# }

