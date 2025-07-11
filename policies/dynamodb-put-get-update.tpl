{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DynamodbPutGetUpdate",
      "Effect": "Allow",
      "Action": ["dynamodb:UpdateItem", "dynamodb:GetItem", "dynamodb:PutItem"],
      "Resource": "arn:${partition}:dynamodb:us-east-1:${account_id}:table/VisitorCount"
    }
  ]
}