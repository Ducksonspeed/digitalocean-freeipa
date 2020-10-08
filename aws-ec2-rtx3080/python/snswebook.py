import boto3
import json

CLIENT = boto3.client("sns")

def lambda_handler(json_input, context):
    json_dump = json.dumps(json_input)
    request = json.loads(json_dump)
    message = request["message"]
    numbers = ["+447591895026"] 
    for number in numbers:
        response = CLIENT.publish(
            PhoneNumber=number,
            Message=message,
            MessageAttributes={
                'AWS.SNS.SMS.SenderID':
                {
                    'DataType': 'String',
                    'StringValue': 'Grafana'
                }
            }
        )
    return response