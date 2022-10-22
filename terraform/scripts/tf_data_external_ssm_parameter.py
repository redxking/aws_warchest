from re import I
import sys
import json

import boto3


def main():
    input = sys.stdin.read()
    input_json = json.loads(input)

    client = boto3.client('ssm', region_name=input_json['aws_region'])
    try:
        resp = client.get_parameter(
            Name=input_json['ssm_parameter_name'],
            WithDecryption=True
        )
        param_value = resp['Parameter']['Value']
    except client.exceptions.ParameterNotFound as err:
        param_value = input_json.get('default_value', '')

    output_json = json.dumps({"value": param_value})
    print(output_json)


if __name__ == '__main__':
    main()