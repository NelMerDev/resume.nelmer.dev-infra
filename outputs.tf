output "visitor-counter_function_arn" {
  value = module.visitor_counter_lambda.lambda_function_arn
}

output "cloudflare_function_arn" {
  value = module.cloudflare_s3_policy_updater_lambda.lambda_function_arn
}

output "eventbridge_rule_arns" {
  value = module.eventbridge.eventbridge_rule_arns
}