import json
import boto3

def lambda_handler(event, context):

    # "event" has all our info. Get the HTTP method.
    httpMethod = event["httpMethod"]

    # If it is a POST, get the eventBody JSON.
    if httpMethod == "POST":

      eventBody = json.loads(event["body"])

      pageURL = ""
      if ("pageURL" in eventBody):
          pageURL = eventBody["pageURL"];
          # Log this vote into CloudWatch
          print("VOTE {}".format(pageURL))

      return {
          'statusCode': 200,
          'headers': {
              "Access-Control-Allow-Origin": "https://YOUR-DOMAIN-NAME-HERE",
              "Access-Control-Allow-Headers": "Content-Type"
            },
          'body': json.dumps('Vote recorded.')
      }
    # Else HTTP Method is not a post, return the default.
    else:
      return {
        'statusCode': 200,
        'headers': {
              "Access-Control-Allow-Origin": "https://YOUR-DOMAIN-NAME-HERE",
              "Access-Control-Allow-Headers": "Content-Type"
            },
        'body': 'OK. Non POST used. Try POST instead.'
      }
