import boto3
import json

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('VisitorCount')

    response = table.get_item(Key={'id': 'visitor_count'})

    if 'Item' in response:
        count = response['Item']['count'] + 1
        table.update_item(
            Key={'id': 'visitor_count'},
            UpdateExpression='SET #c = :val',
            ExpressionAttributeNames={'#c': 'count'},
            ExpressionAttributeValues={':val': count}
        )
    else:
        count = 1
        table.put_item(Item={'id': 'visitor_count', 'count': count})

    # Convert Decimal to int before JSON serialization
    count = int(count)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': 'https://resume.nelmer.dev',
            'Content-Type': 'application/json'
        },
        'body': json.dumps({'count': count})
    }

