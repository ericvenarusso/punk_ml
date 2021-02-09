import base64
import json


def lambda_handler(event, context):
    output = []

    for record in event['records']:
        payload = json.loads(base64.b64decode(record['data']))
        payload_cleaned = {
            "id": payload["id"],
            "name": payload["name"],
            "abv": payload["abv"],
            "ibu": payload["ibu"],
            "target_fg": payload["target_fg"],
            "target_og": payload["target_og"],
            "ebc": payload["ebc"],
            "srm": payload["srm"],
            "ph": payload["ph"]
        }
        
        output_record = {
            "recordId": record['recordId'],
            "result": "Ok",
            "data": base64.b64encode(json.dumps(payload_cleaned).encode('utf-8')).decode('utf-8')
        }
        
        output.append(output_record)
              
    return {'records': output}
