import os
import sys
import csv
from azure.storage.blob import BlobServiceClient, ContainerClient, BlobClient, DelimitedTextDialect, BlobQueryError
import logging


def accelerated_query(blob_client: BlobClient, query: str):
    result = dump_query_csv(blob_client, query, True)
    return result


def dump_query_csv(blob_client, query: str, headers: bool):
    # [instatiate blob client object]
    blob = blob_client(
        account_url=os.getenv("BLOB_URL"),
        container_name=os.getenv("BLOB_CONTAINER"),
        blob_name=os.getenv("BLOB"),
        credential=os.getenv("BLOB_CREDENTIAL"))

    # [query data from blob]
    qa_reader = blob.query_blob(
        query_expression=query,
        blob_format=DelimitedTextDialect(has_header=headers),
        on_error=BlobQueryError())

    logging.warning(qa_reader)
    # records() returns a generator that will stream results as received. It will not block pending all results.
    csv_reader = csv.reader(qa_reader.records())
    result = ["*".join(row) for row in csv_reader]
    return result
