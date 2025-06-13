import json
import os

def handler(event, context):
    for record in event['Records']:
        # Process Kinesis record
        payload = record['kinesis']['data']
        # Example: print payload
        print(f"Decoded payload: {payload}")

        # In a real scenario, you would process the data and store it in S3
        # s3_bucket_name = os.environ.get('S3_BUCKET_NAME')
        # print(f"Storing data in S3 bucket: {s3_bucket_name}")

    return {
        'statusCode': 200,
        'body': json.dumps('Processed Kinesis records')
    }


