import boto3

s3_client = boto3.client('s3')

bucket_name = 'tech257-morgan-tech257-morgan-boto3'

region = 'eu-west-1'

try:
    response = s3_client.upload_file('test.txt', bucket_name, 'test.txt')
    print(f"File uploaded to {bucket_name}")
except ClientError as e:
    print(f"Error uploading file: {e}")
