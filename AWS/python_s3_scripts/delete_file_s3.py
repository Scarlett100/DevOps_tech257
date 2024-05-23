import boto3

s3_client = boto3.client('s3')

bucket_name = "tech257-morgan-tech257-morgan-boto3"

file_name = "test.txt"

try:
    response = s3_client.delete_object(Bucket=bucket_name, Key=file_name)
    print(f"File {file_name} deleted from {bucket_name},congratulations!")
except ClientError as e:
    print(f"Error deleting file, please read: {e}")