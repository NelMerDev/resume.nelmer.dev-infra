import {
  to = aws_dynamodb_table.VisitorCount
  id = "VisitorCount"
}
resource "aws_dynamodb_table" "VisitorCount" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = false
  hash_key                    = "id"
  name                        = "VisitorCount"
  read_capacity               = 0
#   region                      = "us-east-1"
  stream_enabled              = false
  table_class                 = "STANDARD"
  tags = {
    ManagedBy = "Terraform"
  }
  write_capacity              = 0
  attribute {
    name = "id"
    type = "S"
  }
  point_in_time_recovery {
    enabled                 = false
    # recovery_period_in_days = 0
  }
  ttl {
    attribute_name = null
    enabled        = false
  }
}