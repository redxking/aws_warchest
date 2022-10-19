import json
import os
import boto3

TARGET_ACCT_NAMES = ["sandox", "develop", "staging", "product"]
TARGET_ACCT_IAM_ROLE_NAME = "CrossAcctAutomationExecutionRole"


JUMPBOX_EC2_FILTERS = [
    {'Name': 'instance-state-name', 'Values': ['running']},
    {'Name': 'tag:Type', 'Values': ['jumpbox']}
]
      

def assume_iam_role(account_id, role_name):
    '''Assume Cross Account IAM Role
    '''
    sts_connection = boto3.client('sts')
    acct_b = sts_connection.assume_role(
        RoleArn=f'arn:aws:iam::{account_id}:role/{role_name}',
        RoleSessionName="cross_acct_lambda"
    )
  
    return { 
        'aws_access_key_id': acct_b['Credentials']['AccessKeyId'],
        'aws_secret_access_key': acct_b['Credentials']['SecretAccessKey'],
        'aws_session_token': acct_b['Credentials']['SessionToken']
    }

def create_boto_client(aws_service, account_id='', role_name=''):
    '''Cteate Boro3 Client
    '''
    creds = {}
    if account_id and role_name:
        creds = assume_iam_role(account_id, role_name)
    # create service client using the assumed role credentials
    return boto3.client(aws_service, **creds)

def extract_org_accounts(cli):
    '''Extract AWS Organization Accounts
    '''
    extra_args = {}
    while True:
        resp = cli.list_accounts(**extra_args)
        yield from resp['Accounts']

        if not 'NextToken' in resp:
          break

        extra_args['NextToken'] = resp['NextToken']

def extract_ec2_instances(cli, filters=[]):
    '''Extract AWS EC2 Instances
    '''
    extra_args = {'Filters': filters}
    while True:
        resp = cli.describe_instances(**extra_args)
        for reservation in resp['Reservations']:
            yield from reservation['Instances']
        
        if not 'NextToken' in resp:
            break

        extra_args['NextToken'] = resp['NextToken']


def main():

    org_cli = create_boto_client('organizations')

    for account in extract_org_accounts(org_cli):
        if not account["Name"].lower() in TARGET_ACCT_NAMES:
            continue

        print(f'Extracted Account - Id: {account["Id"]}, Name: {account["Name"]}')
        target_ec2_cli = create_boto_client(
            'ec2',
            account['Id'],
            TARGET_ACCT_IAM_ROLE_NAME
        )
        jumpbox_instance_ids = [i['InstanceId'] for i in \
            extract_ec2_instances(target_ec2_cli, JUMPBOX_EC2_FILTERS)]
        print(f'Stopping Jumpbox EC2 Instances - Count: {len(jumpbox_instance_ids)}')
        if jumpbox_instance_ids:
            print(target_ec2_cli.stop_instances(
              InstanceIds=jumpbox_instance_ids,
              DryRun=False
            ))

def lambda_handler(event, context):
    main()


if __name__ == '__main__':
    main()