# import {
#   to = aws_apigatewayv2_api.VisitorCounterAPI
#   id = "hj5nir8cjg"
# }
resource "aws_apigatewayv2_api" "VisitorCounterAPI" {
  api_key_selection_expression = "$request.header.x-api-key"
  disable_execute_api_endpoint = false
  ip_address_type              = "ipv4"
  name                         = "VisitorCounterAPI"
  protocol_type                = "HTTP"
#   region                       = "us-east-1"
  route_selection_expression   = "$request.method $request.path"
  tags = {
    ManagedBy = "Terraform"
  }
}