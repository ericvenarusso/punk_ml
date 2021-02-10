import json
import boto3
from botocore.vendored import requests

STREAM_NAME = 'punk_data_stream_terraform'
KINESIS_CLIENT = boto3.client('kinesis')


def lambda_handler(event, lambda_context):
	# Realizando o get na API para a ingestao dos dados
    response = requests.get("https://api.punkapi.com/v2/beers/random")
    data = response.json()[0]
    
    # Enviando os dados para o Kinesis
    put_response = KINESIS_CLIENT.put_record(
        StreamName=STREAM_NAME,
        Data=json.dumps(data),
        PartitionKey="partition_key"
    )
 	
 	return data
 	