import logging
import boto3
from botocore.exceptions import ClientError

def delete_bucket(bucket_name):
    """Delete an S3 bucket

    :param bucket_name: Bucket to delete
    :return: True if bucket was deleted, else False
    """

    # Delete the bucket
    try:
        s3_client = boto3.client('s3')
        s3_client.delete_bucket(Bucket=bucket_name)
        return True
    except ClientError as e:
        logging.error(e)
        return False

# Call the function to delete the bucket
delete_bucket("tech257-morgan-tech257-morgan-boto3")