import boto3
import requests
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

# Source file for this guided lab.
# This is a raw JSON file hosted on GitHub.
GITHUB_URL = "https://raw.githubusercontent.com/deacademygit/project-data/refs/heads/main/country_details.json"

# S3 target location.
# Replace this with the bucket you created for this project.
BUCKET_NAME = "dea-glue-dbt-api-data-jenny"
S3_KEY = "data/country_details.json"


def fetch_data_from_github_and_upload_to_s3(github_url: str, bucket_name: str, s3_key: str) -> None:
    """
    Pulls a JSON file from a public GitHub raw URL and uploads it to S3.

    In this project, AWS Glue is being used as the extraction step:
    external API/raw source -> Glue Python job -> S3 landing folder.
    """
    try:
        print(f"Fetching data from: {github_url}")
        response = requests.get(github_url, timeout=30)
        response.raise_for_status()

        file_content = response.content

        print(f"Uploading file to s3://{bucket_name}/{s3_key}")
        s3_client = boto3.client("s3")
        s3_client.put_object(
            Bucket=bucket_name,
            Key=s3_key,
            Body=file_content,
            ContentType="application/json",
        )

        print(f"File uploaded successfully to s3://{bucket_name}/{s3_key}")

    except (NoCredentialsError, PartialCredentialsError) as credential_error:
        print(f"AWS credentials are missing or incomplete: {credential_error}")
        raise

    except requests.exceptions.RequestException as request_error:
        print(f"Error fetching the file from GitHub: {request_error}")
        raise

    except Exception as error:
        print(f"Error uploading file to S3: {error}")
        raise


fetch_data_from_github_and_upload_to_s3(GITHUB_URL, BUCKET_NAME, S3_KEY)